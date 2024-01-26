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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.10.0/ComoduleKit_v1.10.0.xcframework.zip",
			checksum: "be701407e3a839ef1c2a6b3d830e21ca63e1db9fd0e45be96f48d6f0d2036d16"
        )
    ]
)
