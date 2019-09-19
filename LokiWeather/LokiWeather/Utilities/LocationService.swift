//
//  LocationService.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation
import CoreLocation

extension Notification.Name {
	static let currentLocationUpdated = Notification.Name(Notifications.currentLocationUpdated.rawValue)
}

class LocationService: NSObject {
	
	// MARK: - Properties
	static let shared = LocationService()
	private lazy var locationManager: CLLocationManager = {
		let manager = CLLocationManager()
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.startMonitoringSignificantLocationChanges()
		manager.delegate = self
		manager.requestWhenInUseAuthorization()
		
		return manager
	}()
	var userLocation: CLLocation?
	
	// MARK: - Initializer
	private override init() {}
	
	// MARK: - Public API
	func startMonitoring() {
		locationManager.startMonitoringSignificantLocationChanges()
	}
	
	func stopMonitoring() {
		locationManager.stopMonitoringSignificantLocationChanges()
	}
	
}

extension LocationService: CLLocationManagerDelegate {
	
	// MARK: - CLLocationManagerDelegate
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			userLocation = location
			Logger.log(message: "User location updated: \(location.coordinate.latitude),\(location.coordinate.longitude)", type: .debug)
			
			NotificationCenter.default.post(name: .currentLocationUpdated, object: location)
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		Logger.log(message: "CLLocationManager error: \(error.localizedDescription)", type: .error)
	}
	
}
