//
//  WeekDayViewModel.swift
//  WeatherAppTests
//
//  Created by Aleksey on 0629..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeekDayViewModelTests: XCTestCase {
	
	var viewModel: WeekDayViewModel!
	
	override func setUp() {
		super.setUp()
		
		let data = loadStub(name: "darksky", extension: "json")
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
		
		viewModel = WeekDayViewModel(weatherData: darkSkyResponse.forecast[5])
	}
	
	func testDay() {
		XCTAssertEqual(viewModel.day, "Monday")
	}
	
	func testDate() {
		XCTAssertEqual(viewModel.date, "June 29")
	}
		
	func testTemperature() {
		XCTAssertEqual(viewModel.temperature, "71.0 °F - 80.2 °F")
	}
		
	func testWindSpeed() {
		XCTAssertEqual(viewModel.wind, "5 MPH")
	}
		
	func testImage() {
		let viewModelImage = viewModel.image
		let imageDataViewModel = viewModelImage!.pngData()!
		let imageDataReference = UIImage(named: "clear-day")!.pngData()!
		
		XCTAssertNotNil(viewModelImage)
		XCTAssertEqual(viewModelImage!.size.width, 48.0)
		XCTAssertEqual(viewModelImage!.size.height, 48.0)
		XCTAssertEqual(imageDataViewModel, imageDataReference)
	}
	
}
