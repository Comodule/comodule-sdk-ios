import ComoduleKit
import Combine
import NordicDFU
import UIKit

public final class ComoduleKit {
	
	private init() {}
	
	public static var discoveredModulesPublisher: AnyPublisher<[CMModule], Never> {
		Comodule.discoveredModulesPublisher
	}
	
	public static var connectionStatePublisher: AnyPublisher<CMModuleConnectionState, Never> {
		Comodule.connectionStatePublisher
	}
	
	public static var isScanningPublisher: AnyPublisher<Bool, Never> {
		Comodule.isScanningPublisher
	}
	
	public static var propertiesPublisher: AnyPublisher<CMPropertiesOutput<CMProperty>, Never> {
		Comodule.propertiesPublisher
	}
	
	public static var firmwareInfoPublisher: AnyPublisher<CMOutput<CMFirmwareInfo>, Never> {
		Comodule.firmwareInfoPublisher
	}
	
	public static var firmwareUpdateStatusPublisher: AnyPublisher<CMFirmwareUpdateStatus, Never> {
		Comodule.firmwareUpdateStatusPublisher
	}
	
	public static var logsPublisher: AnyPublisher<[String], Never> {
		Comodule.logsPublisher
	}
	
	public static func application(
		didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
	) {
		Comodule.application(didFinishLaunchingWithOptions: options)
	}
	
	public static func configure(options: ComoduleConfigurationOptions? = nil) {
		Comodule.configure(options: options)
	}
	
	public static func setApiKey(key: String?) {
		Comodule.setApiKey(key: key)
	}
	
	public static func setDiscoveryDelegate(delegate: ComoduleDiscoveryDelegate) {
		Comodule.setDiscoveryDelegate(delegate: delegate)
	}
	
	public static func discoverModules() {
		Comodule.discoverModules()
	}
	
	public static func stopDiscovery() {
		Comodule.stopDiscovery()
	}
	
	public static func isScanning() -> Bool {
		Comodule.isScanning()
	}
	
	public static func connect(
		serial: String,
		secret: String? = nil,
		completion: @escaping (CMResult<ComoduleConnectionError>) -> Void
	) {
		Comodule.connect(serial: serial, secret: secret, completion: completion)
	}
	
	public static func disconnectModule() {
		Comodule.disconnectModule()
	}
	
	public static func currentFirmwareInfo() -> CMOutput<CMFirmwareInfo> {
		Comodule.currentFirmwareInfo()
	}
	
	public static func currentProperties() -> CMPropertiesOutput<CMProperty> {
		Comodule.currentProperties()
	}
	
	public static func currentConnectionState() -> CMModuleConnectionState {
		Comodule.currentConnectionState()
	}
	
	public static func propertyPublisher(
		identifier: String
	) -> AnyPublisher<CMPropertyType, Never> {
		Comodule.propertyPublisher(identifier: identifier)
	}
	
	public static func rangePropertyPublisher(
		identifier: String
	) -> AnyPublisher<CMPropertyOutput<CMRangeProperty>, Never> {
		Comodule.rangePropertyPublisher(identifier: identifier)
	}
	
	public static func statePropertyPublisher(
		identifier: String
	) -> AnyPublisher<CMPropertyOutput<CMStateProperty>, Never> {
		Comodule.statePropertyPublisher(identifier: identifier)
	}
	
	public static func rawPropertyPublisher(
		identifier: String
	) -> AnyPublisher<CMPropertyOutput<CMRawProperty>, Never> {
		Comodule.rawPropertyPublisher(identifier: identifier)
	}
	
	public static func setProperty(
		identifier: String,
		to value: CMWriteValue
	) -> Future<Void, CMWriteError> {
		Comodule.setProperty(identifier: identifier, to: value)
	}
	
	public static func updateFirmware(delegate: CMFirmwareUpdateDelegate) {
		Comodule.updateFirmware(delegate: delegate)
	}
	
	public static func logs() -> [String] {
		Comodule.logs()
	}
	
	public static func clearLogs() {
		Comodule.clearLogs()
	}
}
