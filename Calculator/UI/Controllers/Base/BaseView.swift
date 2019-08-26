//
//  View.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

class BaseView<VM>: UIView {
    var viewModel: VM? {
        didSet {
            bind()
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    init(vm: VM, frame: CGRect) {
        super.init(frame: .zero)
        self.initialize()
        self.viewModel = vm
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    public func initialize() {

    }
    
    public func bind() {
        
    }
}
