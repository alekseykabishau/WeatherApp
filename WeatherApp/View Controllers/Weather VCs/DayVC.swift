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
			dateLabel.textColor = UIColor(red: 0.31, green: 0.72, blue: 0.83, alpha: 1.0)
			dateLabel.font = .systemFont(ofSize: 20.0, weight: .heavy)
		}
	}
	
	@IBOutlet var timeLabel: UILabel! {
		didSet {
			timeLabel.textColor = .black
			timeLabel.font = .systemFont(ofSize: 15.0, weight: .light)
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
			temperatureLabel.font = .systemFont(ofSize: 17.0, weight: .light)
		}
	}
	
	@IBOutlet var windSpeedLabel: UILabel! {
		didSet {
			windSpeedLabel.textColor = .black
			windSpeedLabel.font = .systemFont(ofSize: 17.0, weight: .light)
		}
	}
	
	@IBOutlet var descriptionLabel: UILabel! {
		didSet {
			descriptionLabel.textColor = .black
			descriptionLabel.font = .systemFont(ofSize: 15.0, weight: .light)
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
