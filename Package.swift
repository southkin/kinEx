// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "kinEx",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "kinEx",
            targets: ["kinEx"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/devxoul/Then", from: .init(3, 0, 0))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "kinEx",
            dependencies: [
                "Then"
            ]
        ),
        .testTarget(
            name: "kinExTests",
            dependencies: ["kinEx","Then"]),
    ]
)
