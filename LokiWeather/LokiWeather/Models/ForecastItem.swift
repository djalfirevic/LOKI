//
//  ForecastItem.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation

struct ForecastItem: Codable {
    
    // MARK: - Properties
    var dateTime: TimeInterval
    var main: WeatherItem
    var weather: [Weather]
    var wind: Wind
    var date: Date {
        return Date(timeIntervalSince1970: dateTime)
    }
	var description: String {
		return "\(wind.description)\n\(main.description)"
	}
    
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case main
        case weather
        case wind
    }
    
}

extension ForecastItem: Loggable {
    
    // MARK: - Loggable
    func log() {
        print("DATE: \(date.toString()), TEMPERATURE: \(String(format: "%.0f", main.celsius.temperature))")
    }
    
}

extension ForecastItem: Equatable {

    // MARK: - Equatable
    static func == (lhs: ForecastItem, rhs: ForecastItem) -> Bool {
        return lhs.date.toString() == rhs.date.toString()
    }
    
}
