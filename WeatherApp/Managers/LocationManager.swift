//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Aleksey on 0702..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
	
	private lazy var locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.delegate = self
		return locationManager
	}()
	
	
	// getting location of device is async operation, so need to keep a ref
	private var didReceiveLocation: FetchLocationCompletion?
	
	
	func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
		didReceiveLocation = completion //called when?
		locationManager.requestLocation()
		print("requested location from fetch location method")
	}
}


extension LocationManager: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		print(#function)
		if status == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
		} else if status == .authorizedWhenInUse {
			locationManager.requestLocation()
			print("requested location from didChangeAuthorization")
		} else {
			didReceiveLocation?(nil, .notAuthorizedToRequestLocation)
			didReceiveLocation = nil
		}
	}
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print(#function)
		guard let location = locations.first else { return }
		didReceiveLocation?(Location(locaton: location), nil)
		didReceiveLocation = nil
	}
	
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("LocationManager.Delegate. Unable to fetch location: \(error)")
	}
}


// conv init will be available only in this file
fileprivate extension Location {
	init(locaton: CLLocation) {
		latitude = locaton.coordinate.latitude
		longitude = locaton.coordinate.longitude
	}
}
