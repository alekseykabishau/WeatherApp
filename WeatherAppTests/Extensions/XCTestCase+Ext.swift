//
//  XCTestCase+Ext.swift
//  WeatherAppTests
//
//  Created by Aleksey on 0628..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import XCTest

extension XCTest {
	func loadStub(name: String, extension: String) -> Data {
		let bundle = Bundle(for: classForCoder)
		let url = bundle.url(forResource: name, withExtension: `extension`)
		return try! Data(contentsOf: url!)
	}
}
