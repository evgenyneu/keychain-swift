// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "KeychainSwift",
    platforms: [.iOS(.v9), .macOS(.v10_13), .watchOS(.v4), .tvOS(.v9)],
    products: [
        .library(name: "KeychainSwift", targets: ["KeychainSwift"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "KeychainSwift", dependencies: [], path: "Sources"),
        .testTarget(
            name: "KeychainSwiftTests", 
            dependencies: ["KeychainSwift"],
            exclude: ["ClearTests.swift"]
        )
    ]
)
