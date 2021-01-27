// swift-tools-version:5.0
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
