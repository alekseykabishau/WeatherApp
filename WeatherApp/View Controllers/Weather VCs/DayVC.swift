//
//  DayViewController.swift
//  WeatherApp
//
//  Created by Aleksey on 0624..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

final class DayVC: UIViewController {
	
	
	@IBOutlet var dateLabel: UILabel! {
		didSet {
			dateLabel.textColor = Style.Colors.base
			dateLabel.font = Style.Fonts.heavyLarge
		}
	}
	
	@IBOutlet var timeLabel: UILabel! {
		didSet {
			timeLabel.textColor = .black
			timeLabel.font = Style.Fonts.lightSmall
		}
	}
	
	@IBOutlet var iconImageView: UIImageView! {
		didSet {
			iconImageView.contentMode = .scaleAspectFit
			iconImageView.tintColor = Style.Colors.base
		}
	}
	
	@IBOutlet var temperatureLabel: UILabel! {
		didSet {
			temperatureLabel.textColor = .black
			temperatureLabel.font = Style.Fonts.lightRegular
		}
	}
	
	@IBOutlet var windSpeedLabel: UILabel! {
		didSet {
			windSpeedLabel.textColor = .black
			windSpeedLabel.font = Style.Fonts.lightRegular
		}
	}
	
	@IBOutlet var descriptionLabel: UILabel! {
		didSet {
			descriptionLabel.textColor = .black
			descriptionLabel.font = Style.Fonts.lightSmall
		}
	}
	
	@IBOutlet var activityIndicator: UIActivityIndicatorView! {
		didSet {
			activityIndicator.startAnimating()
			activityIndicator.hidesWhenStopped = true
		}
	}
	
	@IBOutlet var weatherViews: [UIView]! {
		didSet { weatherViews.forEach { $0.isHidden = true } }
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
	
	
	var viewModel: DayViewModel? {
		didSet {
			guard let viewModel = viewModel else { return }
			setupViewModel(with: viewModel)
		}
	}
	
	
	private func setupViewModel(with viewModel: DayViewModel) {
		activityIndicator.stopAnimating()
		dateLabel.text = viewModel.date
		timeLabel.text = viewModel.time
		temperatureLabel.text = viewModel.temperature
		windSpeedLabel.text = viewModel.wind
		iconImageView.image = viewModel.icon
		descriptionLabel.text = viewModel.summary
		
		weatherViews.forEach { $0.isHidden = false }
	}
	
	
	private func setupView() {
		view.backgroundColor = Style.Colors.lightBackgroundColor
	}
}
