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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    final private func initialize() {
        self.addSubviewsWithSvh()
        self.initStyle()
        self.initContraints()
    }
    
    public func addSubviewsWithSvh() {
        fatalError("Must be overriden")
    }
    
    public func initStyle() {
        fatalError("Must be overriden")
    }
    
    public func initContraints() {
        fatalError("Must be overriden")
    }
    
    public func bind() {
        
    }
}
