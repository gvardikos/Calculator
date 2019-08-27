//
//  CAHorizontalStackView.swift
//  Calculator
//
//  Created by George Vardikos on 25/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

final class CAHorizontalStackView: UIStackView {    
    init(dist: UIStackView.Distribution = .fillEqually) {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = dist
        spacing = 1
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
