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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
	
	
	private func setupView() {
		view.backgroundColor = .systemPink
	}
}
