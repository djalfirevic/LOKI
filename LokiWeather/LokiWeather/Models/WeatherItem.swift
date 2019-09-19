//
//  WeatherItem.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation

struct WeatherItem: Codable {
    
    // MARK: - Properties
    var pressure: Double
    var humidity: Int
    var temperature: Double
    var minimumTemperature: Double
    var maximumTemperature: Double
    var kelvin: (temperature: Double, maximumTemperature: Double, minimumTemperature: Double) {
        return (temperature, maximumTemperature, minimumTemperature)
    }
    var celsius: (temperature: Double, maximumTemperature: Double, minimumTemperature: Double) {
        return (toCelsius(kelvin: temperature), toCelsius(kelvin: maximumTemperature), toCelsius(kelvin: minimumTemperature))
    }
    var fahrenheit: (temperature: Double, maximumTemperature: Double, minimumTemperature: Double) {
        return (toFahrenheit(celsius: celsius.temperature), toFahrenheit(celsius: celsius.maximumTemperature), toFahrenheit(celsius: celsius.minimumTemperature))
    }
    var current: String {
        return "\(String(format: "%.0f", fahrenheit.temperature))°F"
    }
	var description: String {
		return "Humidity: \(humidity)\nTemperature: \(current)"
	}
    
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
    
    // MARK: - Private API
    private func toCelsius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    private func toFahrenheit(celsius: Double) -> Double {
        return celsius * 9 / 5 + 32
    }
    
}
