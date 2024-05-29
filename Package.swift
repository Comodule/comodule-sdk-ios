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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.15.0/ComoduleKit_v1.15.0.xcframework.zip",
			checksum: "709504a8096322ba83ab67309c68940cbad7077a1b0ff5c38d14bf2bfbb671c4"
        )
    ]
)
