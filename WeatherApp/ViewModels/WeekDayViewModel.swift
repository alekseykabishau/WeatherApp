//
//  WeekDayViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0628..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

struct WeekDayViewModel {
	
	let weatherData: ForecastWeatherConditions
	
	private let dateFormatter = DateFormatter()
	
	var day: String {
		dateFormatter.dateFormat = "EEEE"
		return dateFormatter.string(from: weatherData.time)
	}
	
	var date: String {
		dateFormatter.dateFormat = "MMMM d"
		return dateFormatter.string(from: weatherData.time)
	}
	
	var temperature: String {
		let min = String(format: "%.1f °F", weatherData.temperatureMin)
		let max = String(format: "%.1f °F", weatherData.temperatureMax)
		return "\(min) - \(max)"
	}
	
	var wind: String {
		return String(format: "%.f MPH", weatherData.windSpeed)
	}
	
	var image: UIImage? {
		return UIImage.imageForIcon(with: weatherData.icon)
	}
}
