//
//  RootViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

class RootViewModel {
	
	var didFetchWeatherData: ((DarkSkyResponse?, Error?) -> Void)?
	
	
	init() {
		fetchWeatherData()
	}
	
	
	private func fetchWeatherData() {
		
		let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
		
		URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
			guard let self = self else { return }
			
			if let error = error {
				self.didFetchWeatherData?(nil, error)
			} else if let data = data {
				let decoder = JSONDecoder()
				do {
					let response = try decoder.decode(DarkSkyResponse.self, from: data)
					self.didFetchWeatherData?(response, nil)
				} catch {
					print("Unable to parse JSON: \(error)")
					self.didFetchWeatherData?(nil, error)
				}
			} else {
				self.didFetchWeatherData?(nil, nil)
			}
			
			guard let response = response as? HTTPURLResponse else { return }
			print(response.statusCode)
			
		}.resume()
	}
}