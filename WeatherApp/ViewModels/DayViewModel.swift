//
//  DayViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0627..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

struct DayViewModel {
	
	let weatherData: CurrentWeatherConditions
	
	private let dateFormatter = DateFormatter()
	
	var date: String {
		dateFormatter.dateFormat = "EEE, MMMM d YYYY"
		return dateFormatter.string(from: weatherData.time)
	}
	
	var time: String {
		dateFormatter.dateFormat = "hh:mm a"
		return dateFormatter.string(from: weatherData.time)
	}
	
	var temperature: String {
		return String(format: "%.1f °F", weatherData.temperature)
	}
	
	var wind: String {
		return String(format: "%.f MPH", weatherData.windSpeed)
	}
	
	var summary: String {
		return weatherData.summary
	}
	
	var icon: UIImage? {
		return UIImage.imageForIcon(with: weatherData.icon)
	}
}
