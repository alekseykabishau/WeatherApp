//
//  LocationService.swift
//  WeatherApp
//
//  Created by Aleksey on 0702..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation


protocol LocationService {
	
	typealias FetchLocationCompletion = (Result<Location, LocationServiceError>) -> Void
	
	func fetchLocation(completion: @escaping FetchLocationCompletion)
}

// specific to protocol error type
enum LocationServiceError: Error {
	case notAuthorizedToRequestLocation
}
