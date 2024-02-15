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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.12.0/ComoduleKit_v1.12.0.xcframework.zip",
			checksum: "1e72f2eb4bef49f8bb22d0a4c9fc12f43462f2f9ba9efc6748b346d7e0928eb9"
        )
    ]
)
