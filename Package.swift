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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.20.0/ComoduleKit_v1.20.0.xcframework.zip",
			checksum: "54cd55cb5ea01e7eeb30931a12c40b883dff704b3014e2c341714dab79869f6f"
        )
    ]
)
