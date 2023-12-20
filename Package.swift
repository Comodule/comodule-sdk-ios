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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.7.0/ComoduleKit_v1.7.0.xcframework.zip",
			checksum: "77fda620deb9960058333dcc27676add708c2946a401351abc78a6ca2747b950"
        )
    ]
)
