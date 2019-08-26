//
//  ConvertDTO.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Foundation

struct LatestDTO: Codable {
    
    struct Rates: Codable {
        let GBP: Double
        let USD: Double
        let JPY: Double
        let AED: Double
        let AFN: Double
    }
    
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: Rates

}
