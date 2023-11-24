# comodule-sdk-ios

The Comodule SDK is a versatile framework designed for native iOS applications, enabling seamless interaction with Comodule modules. It offers an efficient approach to access and modify vehicle information, alter settings, as well as perform data-to-cloud via Bluetooth connectivity. The SDK supports over-the-air firmware updates for the modules.

## Getting Started
This README is intended for developers who are interested in implementing the Comodule SDK into their project. 

### Adding Comodule SDK as a dependency

#### Swift Package Manager
Comodule SDK can be consumed via Swift Package Manager. This can be done in Xcode by navigating to the project settings `Package Dependencies` section. Use the repository URL (https://github.com/Comodule/comodule-sdk-ios) to search for the package. Visit [Releases](https://github.com/Comodule/comodule-sdk-ios/releases) to see which SDK versions are available. We recommend always using the latest version of the SDK.

Comodule SDK package can also be added 
```swift
// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "<Your Product Name>",
	dependencies: [
		.package(
			url: "https://github.com/Comodule/comodule-sdk-ios",
			.exact(from: "<Desired Version. Example: 1.3.0>")
		)
	],
	targets: [.target(name: "<Your Target Name>", dependencies: ["ComoduleKit"])]
)
```

#### Direct download
It is possible to use the Comodule SDK `.xcframework` directly in your project. To do so, visit [Releases](https://github.com/Comodule/comodule-sdk-ios/releases) to download the suitable SDK version.

## Using the framework

### Prepare the project
Comodule SDK uses Bluetooth LE accessories background capability. This has to be enabled in the target Capabilities section. Additionally, make sure the project `Info.plist` file includes `NSBluetoothAlwaysUsageDescription` key with a proper message that tells the user why the app needs access to Bluetooth. 

### Import and configure the framework
To start using the framework, import it.
```swift
import ComoduleKit
```

In `AppDelegate` `application` `didFinishLaunchingWithOptions` method, make sure to configure Comodule Kit. 
```swift
func application(
	_ application: UIApplication,
	didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
	
	// Other code
	Comodule.configure()
	Comodule.application(didFinishLaunchingWithOptions: launchOptions)
	return true
}
```

Using the `.configure()` method uses the default launch options. To define your own, use the `.configure(options: ...)` method instead. 

### Add API key
Make sure to add the API key to ensure that Comodule Kit can function properly. This can be done with the `.configure(options: ...)` method or by calling `Comodule.setApiKey(key:)` method.

## Need help or encountering issues?
Got questions about Comodule solutions or the SDK implementation? Just fill out our [Contact form](https://www.comodule.com/contact).
