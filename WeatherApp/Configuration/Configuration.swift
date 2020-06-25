//
//  Configuration.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation
import CoreLocation

enum Defaults {
	
	static var location = CLLocation(latitude: 40.2068, longitude: -75.0998)
}

enum WeatherService {
	
	private static let apiKey = "2c745dcd4c911f5d486945ea8f00899f"
	private static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
	
	static var authenticatedBaseUrl: URL {
		return baseUrl.appendingPathComponent(apiKey)
	}
}
