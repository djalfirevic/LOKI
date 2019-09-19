//
//  LokiWeatherTests.swift
//  LokiWeatherTests
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import XCTest
import CoreLocation
@testable import LokiWeather

class LokiWeatherTests: XCTestCase {
	
	// MARK: - Properties
	let api = RESTManager.shared
	
	// MARK: - Tests
	func testFetchCityForecast() {
		// Arrange
		let coordinates = CLLocationCoordinate2DMake(51.5073509, -0.1277583)
		let london = City(name: "London", coordinates: coordinates)
		let requestExpectation = expectation(description: "Fetch city forecast.")
		
		// Act
		api.GET(from: london.queryString, completion: { (_response: ForecastItem?, _ error: Error?) in
			requestExpectation.fulfill()
			
			// Assert
			XCTAssertNotNil(_response, "🛑 Fetching forecast failed.")
		})
		
		waitForExpectations(timeout: 5, handler: { (error) in
			if error != nil {
				XCTFail("🛑 Request timed out.")
			}
		})
	}
	
}
