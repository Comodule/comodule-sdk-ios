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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.6.0/ComoduleKit_v1.6.0.xcframework.zip",
			checksum: "5165295515d6b6778550723b47962561f39e5ec18e9db86e870b80cc7c25f0a5"
        )
    ]
)
