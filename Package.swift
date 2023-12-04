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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.4.0/ComoduleKit_v1.4.0.xcframework.zip",
			checksum: "1fc6c153447d1ccd56a070cef5b2ccc5d8dd9a15705433d387e84cc1f12b600b"
        )
    ]
)
