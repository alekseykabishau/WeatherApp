//
//  ForecastViewModel.swift
//  WeatherAppTests
//
//  Created by Aleksey on 0629..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ForecastViewModelTests: XCTestCase {
	
	var viewModel: ForecastViewModel!
	
	override func setUp() {
		super.setUp()
		
		let data = loadStub(name: "darksky", extension: "json")
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		let darkskyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
		viewModel = ForecastViewModel(weatherData: darkskyResponse.forecast)
	}
	
	
	func testNumberOfDays() {
		XCTAssertEqual(viewModel.numberOfDays, 8)
	}
	
	func testViewModelForIndex() {
		let weekdayViewModel = viewModel.viewModel(for: 5)
		
		XCTAssertEqual(weekdayViewModel.day, "Monday")
		XCTAssertEqual(weekdayViewModel.date, "June 29")
		
	}
}
