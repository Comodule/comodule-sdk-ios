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
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.22.0/ComoduleKit_v1.22.0.xcframework.zip",
			checksum: "c96bf2aca9b73518ed2df838cb6a0181125d18b6600a505151b4627fe0863060"
        )
    ]
)
