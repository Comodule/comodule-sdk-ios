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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.18.0/ComoduleKit_v1.18.0.xcframework.zip",
			checksum: "e3084bbfac074557198da7c0c21991cf6c427c4ffcba13d339bcb456c3df4cc5"
        )
    ]
)
