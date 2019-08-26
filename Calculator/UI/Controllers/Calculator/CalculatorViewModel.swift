//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//
import Foundation

final class CalculatorViewModel {
    public var screenText = Observable<String>("")
    
    private var text: String
    
    private var operations = [String]() {
        didSet {
            operations.reverse()
        }
    }
    
    init() {
        text = ""
    }
    
    func doMath() {
        //        equalLabel.isHidden = !equalLabel.isHidden
        guard text != "0" else { return }
        //        operations.append(screenText.value)
        let expression = NSExpression(format: text)
        guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else { return }
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        guard let value = formatter.string(from: NSNumber(value: mathValue)) else { return }
        screenText.value = value
        text.removeAll()
    }

    final public func handle(_ sender: CAButton) {
        sender.zoomIn()
        let temp = sender.titleLabel?.text ?? "0.0"
        
        if temp == "=" {
            doMath()
            return
        }
        
        text.append(temp)
        screenText.value = text
        operations.append(screenText.value)
    }
}

