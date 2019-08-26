//
//  Parser.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Foundation

final public class Parser: BaseParser {
    static let shared = Parser()
    private override init() {}
    
    func parseLatest(_ data: Data) -> LatestDTO? {
        do {
            return try parse(LatestDTO.self, data)
        } catch {
            print("Parser.\(#function) error:", error)
            return nil
        }
    }
}
