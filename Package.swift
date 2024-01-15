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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.8.0/ComoduleKit_v1.8.0.xcframework.zip",
			checksum: "2f1086bd9a36e5a2dc7fd978a47396a799fe65cae682d5137dd0b051ed2de4c2"
        )
    ]
)
