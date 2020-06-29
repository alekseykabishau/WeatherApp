//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Aleksey on 0624..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

final class ForecastVC: UIViewController {
	
	var viewModel: ForecastViewModel? {
		didSet {
			guard let viewModel = viewModel else { return }
			setupViewModel(with: viewModel)
		}
	}
	
	
	@IBOutlet var tableView: UITableView! {
		didSet {
			tableView.isHidden = true
			tableView.dataSource = self
			tableView.separatorInset = .zero
			tableView.estimatedRowHeight = 44.0
			tableView.rowHeight = UITableView.automaticDimension
			tableView.showsVerticalScrollIndicator = false
		}
	}
	
	
	@IBOutlet var activityIndicator: UIActivityIndicatorView! {
		didSet {
			activityIndicator.startAnimating()
			activityIndicator.hidesWhenStopped = true
		}
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
	
	
	private func setupViewModel(with viewModel: ForecastViewModel) {
		activityIndicator.isHidden = true
		tableView.reloadData()
		tableView.isHidden = false
	}
	
	private func setupView() {
		view.backgroundColor = .white
	}
}


extension ForecastVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.numberOfDays ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reuseIdentifier, for: indexPath) as? ForecastCell else {
			fatalError("Unable to deque table view cell")
		}
		
		guard let viewModel = viewModel else { fatalError("No view model present") }
		cell.configure(with: viewModel.viewModel(for: indexPath.row))
		
		return cell
	}
}
