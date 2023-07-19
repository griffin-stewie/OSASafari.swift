// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OSASafari.swift",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "OSASafari",
            targets: ["Safari"]),
    ],
    dependencies: [
        .package(url: "https://github.com/griffin-stewie/OSAScript.swift", branch: "main"),
    ],
    targets: [
        .target(
            name: "Safari",
            dependencies: [
                .product(name: "OSAScript", package: "OSAScript.swift"),
            ]),
    ]
)
