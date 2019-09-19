//
//  MapViewController.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var mapView: MKMapView!
	let viewModel = MapViewViewModel()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupLongPressGestureRecognizer()
		showCachedCities()
    }
	
	// MARK: - Actions
	@objc private func mapLongPressed(_ sender: UILongPressGestureRecognizer) {
		if sender.state != UIGestureRecognizer.State.began { return }
		
		let location = sender.location(in: mapView)
		
		let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
		
		// Reverse geocoding.
		viewModel.lookUpLocation(from: coordinate) { [weak self] placemark in
			if let placemark = placemark, let name = placemark.locality {
				let city = City(name: name, coordinates: coordinate)
				self?.viewModel.city = city
				self?.mapView.addAnnotation(city)
			}
		}
	}
	
	@objc private func accessoryButtonTapped() {
		guard let city = viewModel.city else { return }
		
		show(city)
	}
	
	// MARK: - Private API
	private func setupLongPressGestureRecognizer() {
		let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapLongPressed(_:)))
		mapView.addGestureRecognizer(gestureRecognizer)
	}

	private func show(_ city: City) {
		if let toViewController = Helpers.initFromStoryboard(name: Storyboards.main.rawValue, identifier: ForecastViewController.identifier) as? ForecastViewController {
			toViewController.city = city
			navigationController?.pushViewController(toViewController, animated: true)
		}
	}
	
	private func showCachedCities() {
		for city in CacheManager.shared.cities {
			mapView.addAnnotation(city)
		}
	}
	
}

extension MapViewController: MKMapViewDelegate {
	
	// MARK: - MKMapViewDelegate
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let identifier = "PinAnnotationIdentifier"
		
		let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
		pinAnnotationView.animatesDrop = true
		pinAnnotationView.canShowCallout = true
		pinAnnotationView.annotation = annotation
		pinAnnotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
		
		return pinAnnotationView
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		if let city = view.annotation as? City {
			show(city)
		}
	}
	
}
