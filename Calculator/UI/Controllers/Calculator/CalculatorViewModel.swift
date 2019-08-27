//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//
import Foundation

// TODO: Add Calculator Class as businnes layer

private let functions = ["*", "/", "+", "-"]

final class CalculatorViewModel {
    public var screenText = Observable<String>("0")
    public var currencyData = Observable<[[String: Double]]>([[String: Double]]())
    
    private var text: [String]
    private var shouldClearScreen: Bool
    private var shouldCalculateCurrencies: Bool
    private var isLocked: Bool
    
    private var latestDto: LatestDTO? {
        didSet {
            shouldCalculateCurrencies = true
        }
    }
    
    init() {
        text = [String]()
        shouldClearScreen = false
        shouldCalculateCurrencies = false
        isLocked = false
        
        fetchCurrencies()
    }

    /// Pass the event of the user to handle the operation
    ///
    /// - Parameter sender: CAButton
    final public func handle(_ sender: CAButton) {
        sender.zoomIn()
        
        let input = sender.titleLabel?.text ?? "0"
        
        switch sender.operationType {
        case .equal: equals()
        case .clear: clear()
        case .number: number(input: input)
        case .function: function(input: input)
        case .minusPlus: minusPlus()
        case .percent: percent()
        }
    }
    
    private func equals() {
        guard !isLocked else { return }
        let result = doMath(text: &text)
        screenText.value = result
        text.removeAll()
        text.append(result)
        if shouldCalculateCurrencies {
            calculateCurrencies(result: result)
        }
    }
    
    private func clear() {
        text.removeAll()
        screenText.value = "0"
        currencyData.value.removeAll()
    }
    
    private func number(input: String) {
        if screenText.value == "0" { screenText.value = "" }
        if input == "." {
            var shouldReturn = false
            for num in text where num.contains(".") {
                shouldReturn = true
            }
            if shouldReturn { return }
        }
        if isLocked { isLocked = false }
        text.append(input)
        if shouldClearScreen {
            screenText.value = input
            shouldClearScreen = false
        } else {
            screenText.value += input
        }
    }
    
    private func function(input: String) {
        if checkLastifFunction() {
            text.removeLast()
        }
        
        isLocked = true
        shouldClearScreen = true
        text.append(input)
    }
    
    private func minusPlus() {
        guard text.count > 0 else { return }
        let negative = "\(turnToNegative(number: screenText.value))"
        text.removeLast()
        text.append(negative)
        screenText.value = negative
    }
    
    private func percent() {
        screenText.value = "\(percent(number: screenText.value))"
        guard let lastNum = text.last else { return }
        repeat {
            guard text.count > 0 else { return }
            text.removeLast()
            print(functions.contains(lastNum))
        } while !functions.contains(text.last ?? "/")
        
        text.append(screenText.value)
    }
    
    private func turnToNegative(number: String) -> Double {
        let dNum = Double(number) ?? 0
        return -dNum
    }
    
    private func percent(number: String) -> Double {
        let dNum = Double(number) ?? 0
        return dNum / 100
    }
    
    private func doMath( text: inout [String]) -> String {
        guard text.count != 0 else { return "Err" }
        if var lastNumber = text.last {
            let containsDot = lastNumber.contains(".")
            if !containsDot {
                lastNumber.append(".0")
                print(lastNumber)
                text.removeLast()
                text.append(lastNumber)
            }
        }
        let expression = NSExpression(format: text.joined())
        guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else {
            return "Err"
        }
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6

        guard let result = formatter.string(from: NSNumber(value: mathValue)) else {
            return "Err"
        }
        return result
    }
    
    private func checkLastifFunction() -> Bool {
        guard let lastNum = text.last else { return false }
        if functions.contains(lastNum) { return true }
        return false
    }
    
    private func fetchCurrencies() {
        FixerRepository.shared.fetchLatest(symbols: "GBP,USD,JPY,AED,AFN") { [unowned self] (responseDto, error) in
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
        let jpyRate = latestDto?.rates.JPY ?? 0
        let aedRate = latestDto?.rates.AED ?? 0
        let afnRate = latestDto?.rates.AFN ?? 0
        
        let doubleResult = Double(result) ?? 0
        
        var tempDict = [[String: Double]]()
        tempDict.append(["GBP": gbpRate * doubleResult])
        tempDict.append(["USD": usdRate * doubleResult])
        tempDict.append(["JPY": jpyRate * doubleResult])
        tempDict.append(["AED": aedRate * doubleResult])
        tempDict.append(["AFN": afnRate * doubleResult])
        
        currencyData.value = tempDict
    }
}
