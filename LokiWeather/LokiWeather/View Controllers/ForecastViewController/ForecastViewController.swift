//
//  ForecastViewController.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import UIKit
//import GooglePlaces

final class ForecastViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var currentImageView: UIImageView!
    @IBOutlet private weak var currentTemperatureLabel: UILabel!
	@IBOutlet private weak var allDataLabel: UILabel!
    private lazy var forecastViewModel: ForecastViewModel = {
        return ForecastViewModel(city: city)
    }()
    var city: City!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
	
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
	
	// MARK: - Actions
	@IBAction private func backButtonTapped() {
		navigationController?.popViewController(animated: true)
	}
    
    // MARK: Private API
    private func setup() {
		if city.forecastItem == nil {
			if RESTManager.shared.hasInternetConnection() {
				forecastViewModel.fetchForecast { [weak self] in
					self?.storeCityToCache()
					self?.refresh()
				}
			} else {
				presentAlert(Messages.noInternetConnection.rawValue, message: Messages.error.rawValue)
			}
		} else {
			refresh()
		}
    }
    
    private func refresh() {
		if let imageUrl = forecastViewModel.currentImageUrl {
			currentImageView.loadImage(from: imageUrl)
		}
		
        currentTemperatureLabel.text = forecastViewModel.currentTemperature
		allDataLabel.text = forecastViewModel.allData
    }
	
	private func storeCityToCache() {
		CacheManager.shared.store(city)
	}
	
}
