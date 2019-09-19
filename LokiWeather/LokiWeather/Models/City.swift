//
//  City.swift
//  LokiWeather
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import Foundation
import MapKit

class City: NSObject, Codable {
    
    // MARK: - Properties
    var name = ""
    var placeID = ""
    var coordinates: CLLocationCoordinate2D!
    var queryName: String {
        return name.replacingOccurrences(of: " ", with: "")
    }
	var queryString: String {
		return "lat=\(coordinates.latitude)&lon=\(coordinates.longitude)"
	}
    var forecastItem: ForecastItem?
	override var description: String {
		return "Forecast: \(forecastItem?.description ?? "")"
	}
	
	// MARK: - Codable
	enum CodingKeys: String, CodingKey {
		case name
		case placeID
		case coordinates
		case forecastItem
	}
	
    // MARK: - Initializers
	init(name: String, coordinates: CLLocationCoordinate2D) {
		self.name = name
		self.coordinates = coordinates
	}
	
	init(name: String, placeID: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.placeID = placeID
		self.coordinates = coordinates
    }
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		placeID = try container.decode(String.self, forKey: .placeID)
		coordinates = try container.decode(CLLocationCoordinate2D.self, forKey: .coordinates)
		forecastItem = try container.decode(ForecastItem.self, forKey: .forecastItem)
	}
	
	// MARK: - Encodable
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(placeID, forKey: .placeID)
		try container.encode(coordinates, forKey: .coordinates)
		try container.encode(forecastItem, forKey: .forecastItem)
	}
    
}

extension City: MKAnnotation {
    
    // MARK: - Properties
    public var title: String? {
        return name
    }
    
    public var subtitle: String? {
        return ""
    }
    
    public var coordinate: CLLocationCoordinate2D {
        return coordinates
    }
    
}

extension CLLocationCoordinate2D: Codable {
	public enum CodingKeys: String, CodingKey {
		case latitude
		case longitude
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(latitude, forKey: .latitude)
		try container.encode(longitude, forKey: .longitude)
	}
	
	public init(from decoder: Decoder) throws {
		self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decode(Double.self, forKey: .latitude)
		longitude = try values.decode(Double.self, forKey: .longitude)
	}
}
