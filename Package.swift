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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.14.0/ComoduleKit_v1.14.0.xcframework.zip",
			checksum: "d1315ad9eb96ab957611934583ac56bd5c16ff68683f6846a4c6e8a4a8a9ab46"
        )
    ]
)
