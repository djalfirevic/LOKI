//
//  Wind.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation

struct Wind: Codable {
    
    // MARK: - Properties
    var speed: Float
    var degrees: Float
	var description: String {
		return "Wind speed: \(speed)\n Wind degrees: \(degrees)"
	}
	
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case degrees = "deg"
        case speed
    }
    
}
