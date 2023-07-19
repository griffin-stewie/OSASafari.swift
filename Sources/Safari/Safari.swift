import Foundation
import OSAScript

public struct Safari {
    public enum Error: LocalizedError {
        case unknown
        case commandFailed(Int32)
        case custom(String)

        public var errorDescription: String? {
            switch self {
            case .unknown:
                return "initialization is failed"
            case .commandFailed(let statusCode):
                return "command exit with code: \(statusCode)"
            case .custom(let string):
                return string
            }
        }
    }
        
    public init() { }
    
    /// Get a active window's active tab.
    /// - Returns: a active window's active tab
    public func activeTab() throws -> Tab {
        let osa = OSAScript()
        let script = """
        const safari = Application("Safari");
        const currentTab = safari.windows[0].currentTab;
        const title = currentTab.name();
        const url = currentTab.url();
        JSON.stringify({title: title, url: url})
        """
        
        let str = try osa.run(script: script, language: .javaScript)!.trimmingCharacters(in: .whitespacesAndNewlines)
        return try JSONDecoder().decode(Safari.Tab.self, from: str.data(using: .utf8)!)
    }
    
    @discardableResult
    public func title(strip: Bool = true) throws -> String {
        let str = try activeTab().title
        if strip {
            return str.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            return str
        }
    }
}

extension Safari {
    public struct Tab: Decodable {
        /// Title
        public let title: String
        
        /// URL
        public let url: URL
    }
}
