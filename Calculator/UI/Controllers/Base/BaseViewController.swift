//
//  BaseViewController.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

extension BaseViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        CALog.shared.log(message: String(describing: self))
    }
}

public class BaseViewController: UIViewController {
    deinit {
        CALog.shared.log(message: String(describing: self))
    }
}
