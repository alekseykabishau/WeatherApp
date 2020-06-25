//
//  DarkSkyResponse.swift
//  WeatherApp
//
//  Created by Aleksey on 0624..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

public struct DarkSkyResponse: Codable {
	
	public struct Conditions: Codable {
		public let time: Date
		public let icon: String
		public let summary: String
		public let windSpeed: Double
		public let temperature: Double
	}
	
	
	public struct Daily: Codable {
		public let data: [Conditions]
		
		public struct Conditions: Codable {
			public let time: Date
			public let icon: String
			public let windSpeed: Double
			public let temperatureMin: Double
			public let temperatureMax: Double
		}
	}
	
	
	public let currently: Conditions
	public let daily: Daily
	
	
	public let longitude: Double
	public let latitude: Double
}

