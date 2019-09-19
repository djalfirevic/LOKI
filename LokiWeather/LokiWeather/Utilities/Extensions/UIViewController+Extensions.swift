//
//  UIViewController+Extensions.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func presentAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
