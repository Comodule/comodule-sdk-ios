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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.21.0/ComoduleKit_v1.21.0.xcframework.zip",
			checksum: "0ec60264541ae817a234b13869a802397a426ce310a0a200c7ec3bcf65ea8c40"
        )
    ]
)
