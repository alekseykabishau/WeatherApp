//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Aleksey on 0624..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

// TODO: - consider creting views sturcture and add child vc's view to them
final class RootVC: UIViewController {

	private let dayVC: DayVC = {
		guard let dayVC = UIStoryboard.main.instantiateViewController(identifier: DayVC.storyboardIdentifir) as? DayVC else { fatalError("Unable to init DayVC")}
		dayVC.view.translatesAutoresizingMaskIntoConstraints = false
		return dayVC
	}()
	
	
	private let forecastVC: ForecastVC = {
		guard let forecastVC = UIStoryboard.main.instantiateViewController(identifier: ForecastVC.storyboardIdentifir) as? ForecastVC else { fatalError("Unable to init ForecastVC")}
		forecastVC.view.translatesAutoresizingMaskIntoConstraints = false
		return forecastVC
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewControllers()
		
		fetchWeatherData()
	}
	
	
	private func setupViewControllers() {
		addChild(dayVC)
		addChild(forecastVC)
		
		view.addSubview(dayVC.view)
		view.addSubview(forecastVC.view)
		
		NSLayoutConstraint.activate([
			dayVC.view.topAnchor.constraint(equalTo: view.topAnchor),
			dayVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			dayVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			dayVC.view.heightAnchor.constraint(equalToConstant: Layout.DayView.height),
			
			forecastVC.view.topAnchor.constraint(equalTo: dayVC.view.bottomAnchor),
			forecastVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			forecastVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			forecastVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		dayVC.didMove(toParent: self)
		forecastVC.didMove(toParent: self)
	}
	
	
	private func fetchWeatherData() {

		let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
		
		URLSession.shared.dataTask(with: weatherRequest.url) { (data, response, error) in
			if let error = error {
				print("request did fail: \(error)")
			}
			
			guard let response = response as? HTTPURLResponse else { return }
			print(response.statusCode)
			
		}.resume()
	}
}


extension RootVC {
	
	fileprivate enum Layout {
		enum DayView {
			static let height: CGFloat = 200.0
		}
	}
}
