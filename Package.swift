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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.5.0/ComoduleKit_v1.5.0.xcframework.zip",
			checksum: "113929b3562a150ea94119e4e9255ef4c65468a9a2611ed6045438518694b4e0"
        )
    ]
)
