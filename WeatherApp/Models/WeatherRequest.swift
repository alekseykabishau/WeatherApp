//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherRequest {
	
	let baseUrl: URL
	let location: CLLocation
	
	var latitude: Double { return location.coordinate.latitude }
	var longitude: Double { return location.coordinate.longitude }
	
	var url: URL {
		return baseUrl.appendingPathComponent("\(latitude),\(longitude)")
	}
}
