//
//  DarkSkyResponse.swift
//  WeatherApp
//
//  Created by Aleksey on 0624..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

struct DarkSkyResponse: Codable {
	
	struct Conditions: Codable {
		let time: Date
		let icon: String
		let summary: String
		let windSpeed: Double
		let temperature: Double
	}
	
	
	struct Daily: Codable {
		let data: [Conditions]
		
		struct Conditions: Codable {
			let time: Date
			let icon: String
			let windSpeed: Double
			let temperatureMin: Double
			let temperatureMax: Double
		}
	}
	
	
	let currently: Conditions
	let daily: Daily
	
	
	let longitude: Double
	let latitude: Double
}

