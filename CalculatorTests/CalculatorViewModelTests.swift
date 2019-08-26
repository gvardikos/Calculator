//
//  CalculatorViewModelTests.swift
//  CalculatorTests
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorViewModelTests: XCTestCase {
    
    var viewModel: CalculatorViewModel?
    
    override func setUp() {
        viewModel = CalculatorViewModel()
    }
    
    override func tearDown() { }
    
    func testHandleAddition() {
        viewModel?.handle(CAButton(op: .number, title: "2", backgroundColor: .white))
        viewModel?.handle(CAButton(op: .function, title: "+", backgroundColor: .white))
        viewModel?.handle(CAButton(op: .number, title: "2", backgroundColor: .white))
        viewModel?.handle(CAButton(op: .equal, title: "=", backgroundColor: .white))
        
        XCTAssertEqual(viewModel?.screenText.value, "4")
    }
}
