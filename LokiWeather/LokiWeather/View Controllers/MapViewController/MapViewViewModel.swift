//
//  MapViewViewModel.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation
import CoreLocation
import GooglePlaces

class MapViewViewModel {
	
	// MARK: - Properties
	var cities = [City]()
	var location: CLLocation?
	var city: City?
	let placesClient = GMSPlacesClient.init()
	
	// MARK: - Initializer
	init() {
		configureLocationUpdate()
	}
	
	// MARK: - Public API
	func lookUpLocation(from coordinate: CLLocationCoordinate2D, completion: @escaping (CLPlacemark?) -> Void) {
		let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
		let geocoder = CLGeocoder()
		
		geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
			if error == nil {
				let firstLocation = placemarks?[0]
				completion(firstLocation)
			} else {
				completion(nil)
			}
		}
	}
	
	// MARK: - Private API
	private func configureLocationUpdate() {
		NotificationCenter.default.addObserver(forName: .currentLocationUpdated, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
			self?.location = notification.object as? CLLocation
			
			self?.findPlace()
		}
		
		LocationService.shared.startMonitoring()
	}
	
	private func findPlace() {
		let fields = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
		
		placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields) { [weak self] (_ placeLikelihoodList: [GMSPlaceLikelihood]?, _ error: Error?) in
			if let error = error {
				Logger.log(message: error.localizedDescription, type: .error)
				return
			}
			
			if let placeLikelihoodList = placeLikelihoodList {
				if let first = placeLikelihoodList.first {
					if let name = first.place.name, let placeID = first.place.placeID {
						self?.city = City(name: name, placeID: placeID, coordinates: first.place.coordinate)
					}
				}
			}
		}
	}
	
}
