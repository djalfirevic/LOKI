//
//  ForecastResponse.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation

struct ForecastResponse: Codable {
    
    // MARK: - Properties
    var list: [ForecastItem]
    var formattedList: [ForecastItem] {
        var results = [ForecastItem]()
        
        for item in list {
            if !results.contains(item) {
                results.append(item)
            }
        }
        
        return results
    }
    
}

extension ForecastResponse: Loggable {
    
    // MARK: - Loggable
    func log() {
        print("\n")
        Logger.log(message: "Forecast fetched", type: .success)
        for item in formattedList {
            item.log()
        }
        print("\n")
    }
    
}
