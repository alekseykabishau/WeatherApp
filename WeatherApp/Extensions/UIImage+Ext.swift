//
//  UIImage+Ext.swift
//  WeatherApp
//
//  Created by Aleksey on 0628..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

extension UIImage {
	
	class func imageForIcon(with name: String) -> UIImage? {
		switch name {
			case "clear-day", "clear-night", "rain", "snow", "sleet", "wind", "fog":
				return UIImage(named: name)
			case "cloudy", "partly-cloudy-day", "partly-cloudy-night":
				return UIImage(named: "cloudy")
			default:
				return nil
		}
	}
}
