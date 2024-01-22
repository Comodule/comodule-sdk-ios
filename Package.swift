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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.9.0/ComoduleKit_v1.9.0.xcframework.zip",
			checksum: "a6bd08021f7f75a9149f907482ac8dd6d3f24dccde64c1f81be463bb94c6498f"
        )
    ]
)
