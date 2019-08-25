//
//  CalculatorButton.swift
//  Calculator
//
//  Created by George Vardikos on 25/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

final class CAButton: UIButton {
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(type: .system)
        initialize(title, backgroundColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(_ title: String = "7", _ backColor: UIColor = .white) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = backColor
    }
}
