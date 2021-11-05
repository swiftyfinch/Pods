// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pods",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "pods", targets: ["Pods"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.1"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.1"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.2.0"),
        .package(url: "https://github.com/kareman/SwiftShell", from: "5.1.0")
    ],
    targets: [
        .target(name: "Pods", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "Rainbow",
            "Files",
            "SwiftShell"
        ])
    ]
)
