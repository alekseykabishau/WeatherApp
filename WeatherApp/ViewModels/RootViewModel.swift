//
//  RootViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

class RootViewModel {
	
	enum WeatherDataError: Error {
		case noWeatherDataAvailable
		case failedToRequestLocation
		case notAuthorizedToRequestLocation
	}
	
	let locationService: LocationService
	
	var didFetchWeatherData: ((WeatherData?, WeatherDataError?) -> Void)?
	
	
	init(locationService: LocationService) {
		self.locationService = locationService
		
		fetchWeatherData(for: Defaults.location)
		fetchLocation()
	}
	
	
	private func fetchLocation() {
		print(#function)
		
		locationService.fetchLocation { [weak self] location, error in
			guard let self = self else { return }
			
			if let error = error {
				print("Unable to Fetch Location (\(error))")
				self.didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
			} else if let location = location {
				self.fetchWeatherData(for: location)
			} else {
				print("RootViewModel. Unable to fetch location")
				self.didFetchWeatherData?(nil, .failedToRequestLocation)
			}
		}
	}
	
	
	private func fetchWeatherData(for location: Location) {
		print(#function)
		let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: location)
		
		URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
			guard let self = self else { return }
			
			DispatchQueue.main.async {
				if let error = error {
					print("Unable to fetch weather data: \(error)")
					self.didFetchWeatherData?(nil, .noWeatherDataAvailable)
				} else if let data = data {
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .secondsSince1970
					do {
						let response = try decoder.decode(DarkSkyResponse.self, from: data)
						self.didFetchWeatherData?(response, nil)
					} catch {
						print("Unable to parse JSON: \(error)")
						self.didFetchWeatherData?(nil, .noWeatherDataAvailable)
					}
				} else {
					self.didFetchWeatherData?(nil, .noWeatherDataAvailable)
				}
				
				guard let response = response as? HTTPURLResponse else { return }
				print(response.statusCode)
				print(weatherRequest.url)
			}
			
		}.resume()
	}
}
