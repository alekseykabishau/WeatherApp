//
//  DayViewModelTests.swift
//  WeatherAppTests
//
//  Created by Aleksey on 0628..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DayViewModelTests: XCTestCase {
	
	var viewModel: DayViewModel!
	
	override func setUp() {
		super.setUp()
		
		let data = loadStub(name: "darksky", extension: "json")
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		let darkskyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
		viewModel = DayViewModel(weatherData: darkskyResponse.current)
	}

	func testDate() {
		XCTAssertEqual(viewModel.date, "Wed, June 24 2020")
	}
	
	func testTime() {
		XCTAssertEqual(viewModel.time, "08:50 PM")
	}
	
	func testTemperature() {
		XCTAssertEqual(viewModel.temperature, "80.2 °F")
	}
	
	func testWindSpeed() {
		XCTAssertEqual(viewModel.wind, "6 MPH")
	}
	
	func testImage() {
		let viewModelImage = viewModel.icon
		let imageDataViewModel = viewModelImage?.pngData()
		let imageDataReference = UIImage(named: "cloudy")!.pngData()
		
		
		XCTAssertNotNil(viewModelImage)
		XCTAssertEqual(imageDataViewModel, imageDataReference)
		
	}
}
