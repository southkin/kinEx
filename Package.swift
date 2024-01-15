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
        .library(
            name: "kinExSwiftUI",
            targets: ["kinExSwiftUI"]
        ),
        .library(
            name: "kinExUIKit",
            targets: ["kinExUIKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/devxoul/Then", from: .init(3, 0, 0)),
        .package(url: "https://github.com/southkin/RedLine", from: .init(1, 0, 0))
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
                "Then",
                "RedLine"
            ],
            path: "Sources/UIKit"
        ),
        .testTarget(
            name: "kinExTests",
            dependencies: ["kinEx","Then"]),
    ]
)
