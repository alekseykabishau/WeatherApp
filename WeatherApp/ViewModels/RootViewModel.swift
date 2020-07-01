//
//  RootViewModel.swift
//  WeatherApp
//
//  Created by Aleksey on 0625..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation
import CoreLocation

class RootViewModel: NSObject {
	
	enum WeatherDataError: Error {
		case noWeatherDataAvailable
		case notAuthorizedToRequestLocation
	}
	
	
	var didFetchWeatherData: ((WeatherData?, WeatherDataError?) -> Void)?
	
	private lazy var locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.delegate = self
		return locationManager
	}()
	
	
	override init() {
		super.init()
		fetchWeatherData(for: Defaults.location)
		fetchLocation()
	}
	
	
	private func fetchLocation() {
		print(#function)
		locationManager.requestLocation() // one-time request
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
			}
			
		}.resume()
	}
}


extension RootViewModel: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
		} else if status == .authorizedWhenInUse {
			fetchLocation()
		} else {
			didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
		}
	}
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print(#function)
		guard let location = locations.first else { return }
		let latitude = location.coordinate.latitude
		let longitude = location.coordinate.longitude
		
		fetchWeatherData(for: Location(latitude: latitude, longitude: longitude))
	}
	
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Unable to fetch location: \(error)")
	}
}
