//
//  CacheManager.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation

class CacheManager {
	
	// MARK: - Properties
	static let shared = CacheManager()
	var cities = [City]()
	private let citiesKey = "Cities"
	
	// MARK: - Initializer
	private init() {
		fetchCities()
	}
	
	// MARK: - Public API
	func store(_ city: City) {
		var savedCities = fetchCities()
		savedCities.append(city)
		
		do {
			let data = try JSONEncoder().encode(savedCities)
			Logger.log(message: "Storing city to cache: \(String(bytes: data, encoding: .utf8) ?? "")", type: .info)
			
			UserDefaults.standard.set(data, forKey: citiesKey)
			UserDefaults.standard.synchronize()
		} catch {
			Logger.log(message: "\(error)", type: .error)
		}
	}
	
	// MARK: - Private API
	@discardableResult
	private func fetchCities() -> [City] {
		if let data = UserDefaults.standard.data(forKey: citiesKey) {
			do {
				let cities = try JSONDecoder().decode([City].self, from: data)
				self.cities = cities
				
				return cities
			} catch {
				Logger.log(message: "\(error)", type: .error)
			}
		}
		
		return []
	}
	
}
