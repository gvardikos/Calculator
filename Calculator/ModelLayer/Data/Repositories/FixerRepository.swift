//
//  FixerRepository.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Foundation

enum RepositoryError: Error {
    case CAError(error: Error)
}

typealias FetchLatestCallback = (LatestDTO?, Error?) -> Void

final public class FixerRepository {
    public static let shared = FixerRepository()
    
    private var networkLayer: INetworkLayer
    private var parser: IParser
    
    private init() {
        networkLayer = NetworkLayer()
        parser = Parser()
    }
}

extension FixerRepository: IFixerRepository {
    /// Calls http://fixer.io API 'latest' enpoint
    ///
    /// - Parameters:
    ///   - symbols: currencies to return
    ///   - completion: (LatestDTO?, Error?) -> Void
    func fetchLatest(symbols: String, completion: @escaping FetchLatestCallback) {
        networkLayer.fetchLatest(symbols: symbols) { [unowned self] (response, error) in
            if let err = error {
                completion(nil, RepositoryError.CAError(error: err))
                return
            }
            
            guard let safeResponse = response else {
                return
            }
            
            if let response = self.parser.parseLatest(safeResponse) {
                completion(response, nil)
            } else {
                completion(nil, NetworkError.server(message: couldNotParseResponseMessage))
            }
        }
    }
}
