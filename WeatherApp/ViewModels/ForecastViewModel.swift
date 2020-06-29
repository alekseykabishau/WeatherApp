//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0628..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

struct ForecastViewModel {
	
	let weatherData: [ForecastWeatherConditions]
	
	
	var numberOfDays: Int {
		return weatherData.count
	}
	
	
	func viewModel(for index: Int) -> WeekDayViewModel {
		return WeekDayViewModel(weatherData: weatherData[index])
	}
}
