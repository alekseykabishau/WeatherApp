//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Aleksey on 0628..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
	
	static var reuseIdentifier: String {
		return String(describing: self)
	}
	
	
	@IBOutlet var dayLabel: UILabel! {
		didSet {
			dayLabel.textColor = .black
			dayLabel.font = Style.Fonts.heavyLarge
		}
	}
	
	@IBOutlet var dateLabel: UILabel! {
		didSet {
			dateLabel.textColor = .black
			dateLabel.font = Style.Fonts.lightRegular
		}
	}
	
	@IBOutlet var temperatureLabel: UILabel! {
		didSet {
			temperatureLabel.textColor = .black
			temperatureLabel.font = Style.Fonts.lightSmall
		}
	}
	
	@IBOutlet var windLabel: UILabel! {
		didSet {
			windLabel.textColor = .black
			windLabel.font = Style.Fonts.lightSmall
		}
	}
	
	@IBOutlet var iconImageView: UIImageView! {
		didSet {
			iconImageView.contentMode = .scaleAspectFit
			iconImageView.tintColor = Style.Colors.base
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        
		selectionStyle = .none // user can't select cell
    }

	
	// TODO: - cell doesn't need to know about specific view model - implement WeekDayRepresentable protocol
	func configure(with viewModel: WeekDayViewModel) {
		dayLabel.text = viewModel.day
		dateLabel.text = viewModel.date
		temperatureLabel.text = viewModel.temperature
		windLabel.text = viewModel.wind
		iconImageView.image = viewModel.image
	}
}
