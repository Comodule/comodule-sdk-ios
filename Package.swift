// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ComoduleKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ComoduleKit",
            targets: ["ComoduleKit"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "ComoduleKit",
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.23.0/ComoduleKit_v1.23.0.xcframework.zip",
			checksum: "c2913ea4e696c0bd3a2a875db063e08e9e0df51f7fbb574fc9cca77a51431084"
        )
    ]
)
