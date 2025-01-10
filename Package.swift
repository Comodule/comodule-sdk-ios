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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.19.0/ComoduleKit_v1.19.0.xcframework.zip",
			checksum: "473a2e4ee81e0046380eded453bd7a2567b38ef97945774d8d016bdba52188f7"
        )
    ]
)
