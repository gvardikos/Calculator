//
//  CurrencyCellViewModel.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Foundation

final public class CurrencyCellViewModel {
    public var label: String
    public var value: String
    
    init(rate: [String: Double]) {
        label = rate.keys.first ?? ""
        value = NSString(format: "%.2f", rate.values.first ?? 0) as String 
    }
}
