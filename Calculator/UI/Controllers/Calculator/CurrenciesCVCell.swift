//
//  CurrenciesCVCell.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

final class CurrenciesCVCell: BaseCVCell {
    lazy var currencyLabel: UILabel = { [unowned self] in
        let lb = UILabel()
        lb.text = "asdf"
        return lb
    }()
    
    lazy var currencyValue: UILabel = { [unowned self] in
        let lb = UILabel()
        lb.text = "asdf"
        return lb
    }()
    
    override func setupCell() {
        setupCurrencyLabel()
        setupCurrencyValue()
    }
    
    private func setupCurrencyLabel() {
        currencyLabel.Top == self.Top
        currencyLabel.Left == self.Left
        currencyLabel.Right == self.Right
        currencyLabel.Bottom == currencyValue.Top
    }
    
    private func setupCurrencyValue() {
        currencyValue.Top == currencyLabel.Bottom + 8
        currencyValue.Left == currencyLabel.Left
        currencyValue.Right == currencyLabel.Right
        currencyValue.Bottom == self.Bottom
    }
}
