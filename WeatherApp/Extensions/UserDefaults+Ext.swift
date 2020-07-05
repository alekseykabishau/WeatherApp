//
//  UserDefaults+Ext.swift
//  WeatherApp
//
//  Created by Aleksey on 0704..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

extension UserDefaults {
	
	private enum Keys {
		static let weatherDataTimeStamp = "weatherDataTimeStamp"
	}
	
	class var weatherDataTimeStamp: Date? {
		
		get { return UserDefaults.standard.object(forKey: Keys.weatherDataTimeStamp) as? Date }
		set { UserDefaults.standard.set(newValue, forKey: Keys.weatherDataTimeStamp) }
	}
}
