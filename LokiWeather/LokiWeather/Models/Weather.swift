//
//  Weather.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    // MARK: - Properties
    var main: String
    var description: String
    var icon: String
    var imageUrl: String {
        return "http://openweathermap.org/img/w/\(icon).png"
    }
    
}
