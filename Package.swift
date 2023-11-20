// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ComoduleSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ComoduleSDK",
            targets: ["ComoduleSDK"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/NordicSemiconductor/IOS-DFU-Library", .exact("4.13.0"))
    ],
    targets: [
        .binaryTarget(
            name: "ComoduleKit",
			url: "https://github.com/Comodule/comodule-sdk-ios/releases/download/v1.0.0/ComoduleKit_v1.0.0.xcframework.zip",
			checksum: "714f68331489b1539210f41900c8b1375fdd11fd9f06512588f9efb73b2d0399"
        ),
        .target(
            name: "ComoduleSDK",
            dependencies: [
				"ComoduleKit",
				.product(name: "NordicDFU", package: "IOS-DFU-Library")
			]
        )
    ]
)
