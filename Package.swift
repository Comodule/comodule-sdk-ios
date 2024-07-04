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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.16.0/ComoduleKit_v1.16.0.xcframework.zip",
			checksum: "2234b6c5f875311c04dc1e38c2123ac31f0ec727b657bc3c44ab3fcabb0749c9"
        )
    ]
)
