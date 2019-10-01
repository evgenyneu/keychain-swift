// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "KeychainSwift",
    products: [
        .library(name: "KeychainSwift", targets: ["KeychainSwift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "KeychainSwift", dependencies: [], path: "Sources"),
        .testTarget(
            name: "KeychainSwiftTests", 
            dependencies: ["KeychainSwift"],
            exclude: ["ClearTests.swift"]
        )
    ]
)
