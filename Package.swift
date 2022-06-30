// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "KeychainSwift",
    products: [
        .library(name: "KeychainSwift", targets: ["KeychainSwift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
          name: "KeychainSwift",
          dependencies: [],
          path: "Sources",
          exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "KeychainSwiftTests",
            dependencies: ["KeychainSwift"],
            exclude: ["Info.plist", "ClearTests.swift","macOS Tests/Info.plist"]
        )
    ]
)
