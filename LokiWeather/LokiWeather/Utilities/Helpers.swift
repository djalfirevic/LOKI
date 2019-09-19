//
//  Helpers.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation
import UIKit

final class Helpers {
    
    // MARK: - Public API
    static func initFromStoryboard(name: String, identifier: String) -> UIViewController {
        return UIStoryboard(name: name, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
    }
    
}
