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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.3.0/ComoduleKit_v1.3.0.xcframework.zip",
			checksum: "67368cdb58a5374a690dd5547a167dafe16f41b50d7bdbb44d3ff40ccba34851"
        )
    ]
)
