//
//  CalculatorView.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

final class CalculatorView: BaseView<CalculatorViewModel> {
    lazy var container: UIView = { [unowned self] in
        let v = UIView()
        v.backgroundColor = .yellow
        return v
    }()
    
    override func addSubviewsWithSvh() {
        sv([container])
    }
    
    override func initStyle() {
        
    }
    
    override func initContraints() {
        container.fillContainer()
    }
}
