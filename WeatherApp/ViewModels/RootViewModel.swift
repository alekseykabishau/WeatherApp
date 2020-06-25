//
//  RootViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

class RootViewModel {
	
	var didFetchWeatherData: ((Data?, Error?) -> Void)?
	
	
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
				self.didFetchWeatherData?(data, nil)
			} else {
				self.didFetchWeatherData?(nil, nil)
			}
			
			guard let response = response as? HTTPURLResponse else { return }
			print(response.statusCode)
			
		}.resume()
	}
}
