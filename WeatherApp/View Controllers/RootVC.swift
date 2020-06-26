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
	
	
	private enum AlertType {
		case noWeatherDataAvailable
	}
	
	
	var viewModel: RootViewModel? {
		didSet {
			guard let viewModel = viewModel else { return }
			setupView(with: viewModel)
		}
	}
	
	private func setupView(with viewModel: RootViewModel) {
		viewModel.didFetchWeatherData = { [weak self] data, error in
			guard let self = self else { return }
			if let _ = error {
				self.showAlert(of: .noWeatherDataAvailable)
			} else if let data = data {
				print(data)
			} else {
				self.showAlert(of: .noWeatherDataAvailable)
			}
		}
	}

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
			// height is set in storyboard using low priority constraint from the last element what provides "flexible" view height
			
			forecastVC.view.topAnchor.constraint(equalTo: dayVC.view.bottomAnchor),
			forecastVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			forecastVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			forecastVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		dayVC.didMove(toParent: self)
		forecastVC.didMove(toParent: self)
	}
	
	
	private func showAlert(of type: AlertType) {
		let title: String
		let message: String
		
		switch type {
			case .noWeatherDataAvailable:
			title = "Unable to fetch weather data"
			message = "The application is unable to get weather data. Please check you internet connection."
		}
		
		DispatchQueue.main.async {
			let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
			let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)
		}
	}
}
