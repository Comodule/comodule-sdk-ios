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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.13.0/ComoduleKit_v1.13.0.xcframework.zip",
			checksum: "76525f6dbd6241bc3bb7d3fdae46be17c15a19816cf4cb6e8d56bc2fd0d87d45"
        )
    ]
)
