//
//  Protocols.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation

protocol Loggable {
    func log()
}

extension Loggable {
    
    func log() {
        Logger.log(message: "Nothing to log here", type: .info)
    }
    
}
