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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.24.0/ComoduleKit_v1.24.0.xcframework.zip",
			checksum: "1b57420bc6517f54cdb574a2e89a7084e67e3ca827ddd5dc5e01e2d31c2cb7f2"
        )
    ]
)
