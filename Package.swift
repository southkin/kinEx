// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "kinEx",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "kinEx",
            targets: ["kinEx"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/devxoul/Then", from: .init(3, 0, 0))
    ],
    targets: [
        .target(
            name: "kinEx",
            dependencies: [
                "Then"
            ]
        ),
        .target(
            name: "kinExSwiftUI",
            dependencies: [
                "Then"
            ],
            path: "Sources/swiftUI"
        ),
        .target(
            name: "kinExUIKit",
            dependencies: [
                "Then"
            ],
            path: "Sources/UIKit"
        ),
        .testTarget(
            name: "kinExTests",
            dependencies: ["kinEx","Then"]),
    ]
)
