// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VCRURLConnection",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_15),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "VCRURLConnection",
            targets: ["VCRURLConnection"]),
    ],
    targets: [
        .target(
            name: "VCRURLConnection",
            dependencies: [],
            path: "Sources",
            exclude: [
                "VCRURLConnection/Info.plist"
            ],
            publicHeadersPath: "VCRURLConnection"),
        .testTarget(
            name: "VCRURLConnectionTests",
            dependencies: ["VCRURLConnection"],
            path: "Tests",
            exclude: [
                "VCRURLConnectionTests/Info.plist"
            ],
            resources: [
                .process("VCRURLConnectionTests/Resources")
            ]),
    ]
)
