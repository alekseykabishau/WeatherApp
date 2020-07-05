//
//  RootViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class RootViewModel {
	
	enum WeatherDataError: Error {
		case noWeatherDataAvailable
		case failedToRequestLocation
		case notAuthorizedToRequestLocation
	}
	
	let locationService: LocationService
	
	var didFetchWeatherData: ((Result<WeatherData, WeatherDataError>) -> Void)?
	
	
	init(locationService: LocationService) {
		self.locationService = locationService
		
		fetchWeatherData(for: Defaults.location)
		setupNotificationHandling()
		fetchLocation()
	}
	
	
	private func fetchLocation() {
		print(#function)
		
		locationService.fetchLocation { [weak self] result in
			guard let self = self else { return }
			
			switch result {
				case .success(let location):
					self.fetchWeatherData(for: location)
				case .failure(_):
					self.didFetchWeatherData?(.failure(.notAuthorizedToRequestLocation))
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
					self.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
				} else if let data = data {
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .secondsSince1970
					do {
						let response = try decoder.decode(DarkSkyResponse.self, from: data)
						self.didFetchWeatherData?(.success(response))
						UserDefaults.weatherDataTimeStamp = Date()
					} catch {
						print("Unable to parse JSON: \(error)")
						self.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
					}
				} else {
					self.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
				}
				
				guard let response = response as? HTTPURLResponse else { return }
				print(response.statusCode)
				print(weatherRequest.url)
			}
			
		}.resume()
	}
	
	
	private func setupNotificationHandling() {
		NotificationCenter.default.addObserver(
			forName: UIApplication.willEnterForegroundNotification,
			object: nil,
			queue: OperationQueue.main) { [weak self] (_) in
				guard let self = self else { return }
				guard let weatherDataTimeStamp = UserDefaults.weatherDataTimeStamp else {
					self.refresh()
					return
				}
				
				
				if Date().timeIntervalSince(weatherDataTimeStamp) > Configuration.refreshThreshold {
					self.refresh()
				}
		}
	}

	
	private func refresh() {
		print(#function)
		fetchLocation()
	}
}
