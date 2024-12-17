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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.17.0/ComoduleKit_v1.17.0.xcframework.zip",
			checksum: "1b2e43c83de8470eaa441297424f42893c588abcaa47f1c3f570ca0e834c2fce"
        )
    ]
)
