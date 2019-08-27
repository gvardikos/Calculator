//
//  BaseParser.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Foundation

public class BaseParser {
    public func parse<T>(_ type: T.Type, _ data: Data?) throws -> T where T: Codable {
        return try JSONDecoder().decode(type, from: data!)
    }
}
