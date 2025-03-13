# Comodule iOS SDK

The Comodule SDK is a versatile framework designed for native iOS applications, enabling seamless interaction with Comodule modules over Bluetooth Low Energy. It offers an efficient approach to access and modify vehicle information, alter settings, as well as perform data-to-cloud. The SDK supports over-the-air firmware updates of the module firmware.

## Table of contents

- [Getting Started](#getting-started)
  - [Adding Comodule SDK as a dependency](#adding-comodule-sdk-as-a-dependency)
    - [Swift Package Manager](#swift-package-manager)
    - [Direct donwload](#direct-download)
- [Using the framework](#using-the-framework)
  - [Prepare the project](#prepare-the-project)
  - [Import and configure the framework](#import-and-configure-the-framework)
  - [Add API key](#add-api-key)
- [Understanding the SDK principles](#understanding-the-sdk-principles)
  - [Module BLE connectivity](#module-ble-connectivity)
    - [Discovering modules](#discovering-modules)
    - [Connecting to module and module status](#connecting-to-module-and-module-status)
    - [Disconnecting from a module](#disconnecting-from-a-module)
  - [Vehicle properties](#vehicle-properties)
    - [Discovering what the module is able to do](#discovering-what-the-module-is-able-to-do)
    - [Property types](#property-types)
    - [Subscribing to Range property value](#subscribing-to-range-property-value)
    - [Subscribing to State property value](#subscribing-to-state-property-value)
    - [Subscribing to Raw property value](#subscribing-to-raw-property-value)
  - [Writing properties](#writing-properties)
    - [Write Range property](#write-range-property)
    - [Write State property](#write-state-property)
    - [Write Raw property](#write-raw-property)
  - [Firmware update](#firmware-update)
    - [Preparations and current firmware info](#preparations-and-current-firmware-info)
    - [Firmware update status](#firmware-update-status)
    - [Starting Firmware update](#starting-firmware-update)
  - [What else can the SDK do?](#what-else-can-the-sdk-do)
    - [Logging](#logging)
    - [Clearing cache](#clearing-cache)
- [Need help or encountering issues?](#need-help-or-encountering-issues)

# Getting Started
This README is intended for developers who are interested in implementing the Comodule SDK into their project. 

## Adding Comodule SDK as a dependency

### Swift Package Manager

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

### Direct download
It is possible to use the Comodule SDK `.xcframework` directly in your project. To do so, visit [Releases](https://github.com/Comodule/comodule-sdk-ios/releases) to download the suitable SDK version.

# Using the framework

## Prepare the project
Comodule SDK uses Bluetooth LE accessories background capability. This has to be enabled in the target Capabilities section. Additionally, make sure the project `Info.plist` file includes `NSBluetoothAlwaysUsageDescription` key with a proper message that tells the user why the app needs access to Bluetooth. 

## Import and configure the framework
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
	Comodule.configure(
		options: .init(
			apiKey: /* API KEY HERE */,
			logToConsole: true / false,
			logLevels: [.error, .warning, .info]
		)
	)
	Comodule.application(didFinishLaunchingWithOptions: launchOptions)
	return true
}
```

Using the `.configure()` method uses the default launch options. To define your own, use the `.configure(options: ...)` method instead. 

## Add API key
Make sure to add the API key to ensure that Comodule Kit can function properly. This can be done with the `.configure(options: ...)` method or by calling `Comodule.setApiKey(key:)` method.

# Understanding the SDK principles
The following section deals with the functionality of the SDK. It covers module discovery, connectivity, module (or vehicle) properties as well as additional functionality like firmware updates.

## Module BLE connectivity

### Discovering modules

In order to connect to a Comodule module, it is necessary to first discover it.

First, subscribe to the discovered modules publisher:
```swift
Comodule
	.discoveredModulesPublisher
	.sink {  modules in
		// handle modules
	}
```

Once subscribed, set the discover delegate and implement the necessary methods. 
The delegate is mainly used to communicate issues when trying to discover nearby modules over BLE.
```swift
Comodule.setDiscoveryDelegate(delegate: /delegate/)
```

Now it is possible to start discovering nearby modules:
```swift
Comodule.discoverModules()
```

It is possible to check if modules are being discovered by subscribing to `Comodule.isScanningPublisher`.

If there are any nearby and charged Comodule modules, `discoveredModulesPublisher` will output and update an array containing such modules. 
The published array is an array of `[CMModule]`. Every `CMModule` contains module `serial` and `name`. 
The serial of the module can be used to connect to it over BLE. The name is mainly used to display or document the name of the nearby module device. 

Do note that if any device is already connected to a nearby Comodule module over BLE, it can not be discovered or connected to due to BLE limitations. The other connection needs to be terminated first.

### Connecting to module and module status

Once a CMModule serial has been obtained it is possible to connect to the module.
To do so, start by subscribing to the module connection status publisher: 


```swift
Comodule
	.connectionStatePublisher
	.sink { [weak self] state in
		switch state {
		case .disconnected:
			// Connection state where connection has yet not started
			// or manual disconnect has been called on the module
		case let .connecting(moduleName, moduleSerial, connectingSubstate):
			switch connectingSubstate {
			case .searching:
				// Connecting substate where a serial has been provided 
				// and the SDK is searching for a module matchin this serial
			case .handshaking:
				// Connecting substate where a serial with the provided serial has been found
				// and the SDK is in the middle of a handshake protocol
			case .firmwareUpdateOngoing:
				// Connecting substate where a serial with the provided serial has been found
				// and the SDK has detected an ongoing firmware update
			}
		case let .connected(moduleName, moduleSerial):
			// Connection state where the module is fully connected over BLE and operational
		}
	}
```

Once subscribed to the connection state publisher, connect to the device:
```swift
Comodule.connect(
	serial: /module serial/, // Serial of the module
	secret: /module secret/, // Secret key of the module. This is used in cases where the module BLE connectivity is guarded with a secret key. Can be null if default key is used.
	completion: { ... } // Returns success once connected or error if the connection fails
)
```

### Disconnecting from a module

Module can be disconnected by calling the following command:
```swift
Comodule.disconnectModule()
```

## Vehicle properties
This section describes how different properties can be read out from the module over BLE and how these properties can be modified. Properties can be something simple like a read-only property of vehicle speed, state of charge or odometer. These properties can also be writable making them essentially a vehicle setting - turning lights on and off, updating motor assist levels or locking the vehicle.

### Discovering what the module is able to do

There is a method that is mainly used to discover which properties the vehicle has available for implementation:
```swift
Comodule
	.propertiesPublisher
	.sink { [weak self] result in
		switch result {
		case .notAvailable:
			// Module is currently outputting no properties. 
			// This result is common when the module is disconnected.
			break
		case let .available(properties):
			// Module is outputting properties
			for property in properties {
				print("Available property: \(property.identifier)")
			}
		}
	}
```

The properties come in an array of `[CMProperty]`. 
`CMProperty` has the following important variables:
- `identifier` - This is the identifier of the property and is used to read and write property values (For example: "speed", "state_of_charge", etc)
- `unitIdentifier` - This is a unit identifier and is used to understand what the unit of the value is (For example: "kilometer_per_hour", "")
- `type` - The type of the property. More on that below.
- `writable` - This is a `Boolean` stating if the property can be edited. If not then the property is considered read-only.
- `variant` - In case of multiple vehicle types, variant is used to distinguish between same properties of multiple vehicles that are handled differently. `variant` is of type `String` and the value is usually agreed between implementer and Comodule.

`CMProperty` has a variable called `type` which helps the implementer understand how the given property should be handled.
To understand which type the property is, it is possible to switch on the property type:

```swift
switch $0.type {
case .range:
	// Property a range-type property
case .states:
	// Property is a states-type property
case .raw:
	// Property is a raw-bytes-type property
}
```

### Property types

Range property - This property is expressed within a range. For example: "State of charge" could be a range-type property that has a value inbetween a range of 0% and 100%. 

States property - This property is expressed by a state. For example: "Lights" could be a states-type property that has a value of `disabled`, `blinking` and `enabled`.

Raw bytes property - This property is expressed by raw bytes. For example: "Motor serial" could be a raw-bytes-type property that outputs `Data` directly which can be translated into a `String`. These properties are flexible types that are used in case other property types do not fit the situation. Raw bytes properties can output up to 8 bytes of data. 

### Subscribing to Range property value

To start receiving a range-type property value, subscribe to it:

```swift
Comodule
	.rangePropertyPublisher(identifier: /property identifier/)
	.sink { output in
		switch type {
			case .notAvailable:
				// The property with this identifier is not available or is of different type
			case let .available(property): 
				// The property is outputting value
		}
	}
```

If the property is available then the output is of type `CMRangeProperty`.
Range property has the following values associated with it:
- `value` - Current value of the property.
- `minValue` - Minimum logical value of the given property. Helper variable lifted from `access`.
- `maxValue` - Maximum logical value of the given property. Helper variable lifted from `access`.
- `access` - Defines if the property is read-only, write-only or read-write. Comes with associated relevant read and/or write data for the property type.
- `info` - Contains a CMProperty object with the relevant property info like `identifier` and `unitIdentifier`.

Here is an example of reading vehicle speed:
```swift
Comodule
	.rangePropertyPublisher(identifier: "speed")
	.sink { output in
		switch type {
			case .notAvailable:
				print("Speed is currently not available")
			case let .available(property): 
				print("\(property.info.identifier) was updated to: \(property.value) \(property.info.unitIdentifier)")
		}
	}
	.store(in: &subscriptions)
```

### Subscribing to State property value

To start receiving a range-type property value, subscribe to it:

```swift
Comodule
	.statePropertyPublisher(identifier: /property identifier/)
	.sink { output in
		switch type {
			case .notAvailable:
				// The property with this identifier is not available or is of different type
			case let .available(property): 
				// The property is outputting value
		}
	}
```

If the property is available then the output is of type `CMStateProperty`.
State property has the following values associated with it:
- `currentState` - Current value of the property.
- `allStates` - Possible values of the property.
- `access` - Defines if the property is read-only, write-only or read-write. Comes with associated relevant read and/or write data for the property type.
- `info` - Contains a CMProperty object with the relevant property info like `identifier` and `unitIdentifier`.

### Subscribing to Raw property value

To start receiving a range-type property value, subscribe to it:

```swift
Comodule
	.rawPropertyPublisher(identifier: /property identifier/)
	.sink { output in
		switch type {
			case .notAvailable:
				// The property with this identifier is not available or is of different type
			case let .available(property): 
				// The property is outputting value
		}
	}
```

If the property is available then the output is of type `CMRawProperty`.
Raw property has the following values associated with it:
- `value` - Current value as Data
- `access` - Defines if the property is read-only, write-only or read-write. Comes with associated relevant read and/or write data for the property type.
- `info` - Contains a CMProperty object with the relevant property info like `identifier` and `unitIdentifier`.

## Writing properties
A property value can be updated if the property is writable. A property is writable if `CMProperty` object `writable` value is `true`, or property `access` value is either `readWrite` or `write`.

### Write Range property

To write Range property value, use the `setProperty` method:
```swift
Comodule
	.setProperty(
		identifier: /property identifier/,
		to: .range(value: /new property value/)
	)
	.sink(
		receiveCompletion: { [weak self] completion in
			switch completion {
			case .finished:
				break
			case let .failure(error):
				// Handle write error
			}
		},
		receiveValue: {}
	)
```

Limits for writing (minimum value, maximum value) are defined in property `access` or `CMRangeProperty` object.

### Write State property

To write State property value, use the `setProperty` method. 
It is possible to either provide an identifier of a valid state:
```swift
Comodule
	.setProperty(
		identifier: /property identifier/,
		to: .rawState(value: /new state identifier/)
	)
	.sink(
		receiveCompletion: { [weak self] completion in
			switch completion {
			case .finished:
				break
			case let .failure(error):
				// Handle write error
			}
		},
		receiveValue: {}
	)
```

Or set the state directly if there is a reference to it:
```swift
Comodule
	.setProperty(
		identifier: /property identifier/,
		to: .state(value: /new valid property state/)
	)
	.sink(
		receiveCompletion: { [weak self] completion in
			switch completion {
			case .finished:
				break
			case let .failure(error):
				// Handle write error
			}
		},
		receiveValue: {}
	)
```

Limits for writing (available states) are defined in property `access` or `CMStateProperty` object.

### Write Raw property

It is possible to write raw bytes into the module if a property allows it:
```swift
Comodule
	.setProperty(
		identifier: /property identifier/,
		to: .bytes(data: /new data/)
	)
	.sink(
		receiveCompletion: { [weak self] completion in
			switch completion {
			case .finished:
				break
			case let .failure(error):
				// Handle write error
			}
		},
		receiveValue: {}
	)
```

Limits for writing (number of bytes) are defined in property `access`.

## Firmware update
It is possible to use the SDK to update the module or vehicle firmware.

### Preparations and current firmware info

Firmware update has to be prepared and validated by the Comodule team. If no firmware update has been set up, the SDK will say that the module is up to date. Firmware updates are mostly provided for Comodule modules but in some cases also to update the firmware of vehicle components. 

To access current firmware info, subscribe to the firmware info publisher:
```swift
Comodule
	.firmwareInfoPublisher
	.sink { [weak self] result in
		switch result {
		case .notAvailable:
			// Usually means module is not connected or a successful handshake has not been performed
		case let .available(firmwareInfo):
			// Firmware info is available
		}
	}
	.store(in: &subscriptions)
```

Firmware info output comes in the form of `CMFirmwareVersionInfo` object. This object contains:
- `firmwareType` - Identifier of the module/vehicle combination
- `firmwareVariant` - Variant of the module/vehicle combination. In most cases this is 0 (no variant).
- `stmVersion` - Primary MCU version.
- `nrfVersion` - Secondary MCU version.
- `nrfBootloaderVersion` - Secondary MCU bootloader version.
- `externalComponents` - Versions of non-Comodule vehicle components.
- `dataToCloud` - Defines if this module performs data-to-cloud. Only supperted on BLE-only modules (GSM modules perform data-to-cloud over GSM).

### Firmware update status

Every time a valid BLE connection is made the SDK makes sure if an update is available.
To access this info, subscribe to the firmware update status publisher:

```swift
Comodule
	.firmwareUpdateStatusPublisher
	.sink { [weak self] status in
			switch status {
				case .moduleNotConnected:
					// Module is not connected over BLE. SDK does not know firmware update status.
				case .fetchingUpdateInfo:
					// SDK is fetching firmware update info and it will become available shortly.
				case .firmwareUpdateAvailable(type: let type):
					// Firmware update is available. Which update is available is defined by associated type.
				case .upToDate:
					// Module firmware is up to date.
				case .firmwareUpdateOngoing(type: let type):
					// Module firmware is currently updating. Which update is ongoing is defined by associated type.
				}
	}
```

### Starting Firmware update

If a firmware update is available for a given connected module, it is possible to start the update:
```swift
Comodule.updateFirmware(delegate: /update delegate/)
```

The firmware update delegate is mainly used to communicate Firmware update errors. 
While a firmware update is ongoing, it is not possible to write module properties.
The update might cause the module to restart, this is not an issue. 
We recommend using debounce when handling firmware update ongoing status to make sure that the update has completed even if a restart occurs. The SDK is unable to determine firmware update status while module is not connected.

## What else can the SDK do?

### Logging

The SDK logs info, warnings and errors. It is possible to access these logs once an event has already occurred.
The SDK caches the last 250 log entries. 

To access SDK logs, use the following method:
```swift
Comodule.logs()
```

To clear the cached log entries, use:
```swift
Comodule.clearLogs()
```

### Clearing cache

Comodule SDK caches some vehicle related info to provide a faster handshake during the connection and allow offline use within reason. 

NB! In most cases clearing cache is never required. The SDK performs its own cache maintenance periodically while the SDK is being used. 

In some edge cases, it might be necessary to clear this cache. To do so, call the following method:
```swift
Comodule.clearCache()
```

# Need help or encountering issues?
Got questions about Comodule solutions or the SDK implementation? Just fill out our [Contact form](https://www.comodule.com/contact).