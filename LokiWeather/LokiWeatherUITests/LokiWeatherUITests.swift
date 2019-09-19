//
//  LokiWeatherUITests.swift
//  LokiWeatherUITests
//
//  Created by Djuro Alfirevic on 9/19/19.
//  Copyright © 2019 LOKI. All rights reserved.
//

import XCTest
@testable import LokiWeather

class LokiWeatherUITests: XCTestCase {
	
	// MARK: - Properties
	var application: XCUIApplication!
	
	// MARK: - Setup
	override func setUp() {
		continueAfterFailure = false
		application = XCUIApplication()
		application.launch()
		XCUIDevice.shared.orientation = .portrait
	}
	
}
