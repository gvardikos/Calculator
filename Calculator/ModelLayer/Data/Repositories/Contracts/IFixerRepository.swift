//
//  IFixerRepository.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Foundation

protocol IFixerRepository {
    func fetchLatest(symbols: String, completion: @escaping FetchLatestCallback)
}
