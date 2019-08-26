//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

extension CalculatorViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

final public class CalculatorViewController: BaseViewController {
    private let contentView = CalculatorView(vm: CalculatorViewModel(), frame: .zero)
    public override func loadView() {
        view = contentView
    }
}
