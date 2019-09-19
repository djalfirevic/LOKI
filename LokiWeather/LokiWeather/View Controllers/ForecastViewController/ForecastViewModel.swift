//
//  ForecastViewModel.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import UIKit

final class ForecastViewModel: NSObject {

    // MARK: - Properties
    private var city: City
    var currentImageUrl: String? {
		return city.forecastItem?.weather[0].imageUrl
    }
    var currentTemperature: String? {
        return city.forecastItem?.main.current
    }
	var allData: String {
		guard let forecastItem = city.forecastItem else { return "" }
		
		return "Name: \(city.name)\n\(forecastItem.description)"
	}
    
    // MARK: - Initializer
    init(city: City) {
        self.city = city
    }
	
	// MARK: - Public API
	func fetchForecast(completion: @escaping () -> Void) {
		RESTManager.shared.GET(from: city.queryString) { [weak self] (_ response: ForecastItem?, _ error: Error?) in
			if let response = response {
				self?.city.forecastItem = response
				completion()
			}
		}
	}
	
}
