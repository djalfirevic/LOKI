//
//  AppDelegate.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder {

	// MARK: - Properties
	var window: UIWindow?
	
	// MARK: - Private API
	private func configureGooglePlaces() {
		GMSPlacesClient.provideAPIKey("AIzaSyBprcpvzaD45Rb1cGv5RQk6QgLqwAgeAMk")
	}

}

extension AppDelegate: UIApplicationDelegate {
	
	// MARK: - UIApplicationDelegate
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		RESTManager.shared.configureNetworkMonitor()
		configureGooglePlaces()
		
		return true
	}
	
}
