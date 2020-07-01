//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

struct WeatherRequest {
	
	let baseUrl: URL
	let location: Location
	
	var latitude: Double { return location.latitude }
	var longitude: Double { return location.longitude }
	
	var url: URL {
		return baseUrl.appendingPathComponent("\(latitude),\(longitude)")
	}
}
