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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.11.0/ComoduleKit_v1.11.0.xcframework.zip",
			checksum: "dd5c8b6547f0387d74a4befc7a113b545182307f1a3ad81ab09e5984390e03d5"
        )
    ]
)
