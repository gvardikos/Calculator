//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//
import Foundation

final class CalculatorViewModel {
    public var screenText = Observable<String>("0")
    public var currencyData = Observable<[String: Double]>([String: Double]())
    
    private var text: String
    private var shouldClearScreen: Bool
    private var shouldCalculateCurrencies: Bool
    
    private var latestDto: LatestDTO? {
        didSet {
            shouldCalculateCurrencies = true
        }
    }
    
    // Keeping the operations so I can provide history to the user
    private var operations = [String]() {
        didSet {
            operations.reverse()
        }
    }
    
    init() {
        text = ""
        shouldClearScreen = false
        shouldCalculateCurrencies = false
        
        fetchCurrencies()
    }

    /// Pass the event of the user to handle the operation
    ///
    /// - Parameter sender: CAButton
    final public func handle(_ sender: CAButton) {
        sender.zoomIn()
        let input = sender.titleLabel?.text ?? "0"
        
        switch sender.operationType {
        case .equal:
            let result = doMath(text: text)
            screenText.value = result
            text.removeAll()
            text = result
            if shouldCalculateCurrencies {
                calculateCurrencies(result: result)
            }
        case .clear:
            text.removeAll()
            screenText.value = "0"
            currencyData.value.removeAll()
        case .number:
            if screenText.value == "0" { screenText.value = "" }
            text.append(input)
            if shouldClearScreen {
                screenText.value = input
                shouldClearScreen = false
            } else {
                screenText.value += input
            }
            operations.append(screenText.value)
        case .function:
            text.append(input)
            operations.append(screenText.value)
            shouldClearScreen = true
        }
    }

    private func doMath(text: String) -> String {
        guard text != "0" else { return "Err" }
        let expression = NSExpression(format: text)
        guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else {
            return "Err"
        }
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        guard let result = formatter.string(from: NSNumber(value: mathValue)) else {
            return "Err"
        }
        return result
    }
    
    private func fetchCurrencies() {
        FixerRepository.shared.fetchLatest(symbols: "GBP,USD") { [unowned self] (responseDto, error) in
            if let err = error {
                CALog.shared.logRaw(err)
                return
            }
            
            guard let dto = responseDto else {
                CALog.shared.log(message: couldNotParseResponseMessage)
                return
            }
            
            self.latestDto = dto
        }
    }
    
    private func calculateCurrencies(result: String) {
        let gbpRate = latestDto?.rates.GBP ?? 0
        let usdRate = latestDto?.rates.USD ?? 0
        
        let doubleResult = Double(result) ?? 0
        var tempDict = [String: Double]()
        tempDict.updateValue(gbpRate * doubleResult, forKey: "GBP")
        tempDict.updateValue(usdRate * doubleResult, forKey: "USD")
        
        currencyData.value = tempDict
    }
}
