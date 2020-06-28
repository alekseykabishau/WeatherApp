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
	}
	
	
	var didFetchWeatherData: ((WeatherData?, WeatherDataError?) -> Void)?
	
	
	init() {
		fetchWeatherData()
	}
	
	
	private func fetchWeatherData() {
		
		let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
		
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
			}
			
		}.resume()
	}
}
