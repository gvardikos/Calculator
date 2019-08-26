//
//  NetworkLayer.swift
//  Calculator
//
//  Created by George Vardikos on 25/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Alamofire

enum NetworkError: Error {
    case server(message: String)
    case emptyResponse(message: String)
}

final class NetworkLayer {
    public static let shared = NetworkLayer()
    
    let session: SessionManager
    
    private init() {
        session = SessionManager()
    }
    
    typealias NetworkResult = (Data?, Error?) -> Void
    typealias FetchLatestCallback = (LatestDTO?, Error?) -> Void

    func fcRequest(_ urlRequest: URLRequestConvertible, completion: @escaping NetworkResult) {
        session.request(urlRequest).responseJSON { (response) in
            switch response.result {
            case .success:
                if let jsonData = response.data {
                    completion(jsonData, nil)
                } else {
                    completion(nil, NetworkError.emptyResponse(message: "Empty Response"))
                }
            case .failure(let error):
                completion(nil, NetworkError.server(message: error.localizedDescription))
            }
        }
    }
}

extension NetworkLayer {
    
    /// latest endpoint will return real-time exchange rate data updated every 60 minutes, every 10 minutes or every 60 seconds.
    ///
    /// - Parameter completion: (LatestDTO?, Error?) -> Void
    func fetchLatest(symbols: String, completion: @escaping FetchLatestCallback) {
        fcRequest(Router.latest(symbols)) { (jsonData, error) in
            if let err = error {
                CALog.shared.logRaw(err)
                return
            }
            
            guard let safeJson = jsonData else {
                CALog.shared.log(message: couldNotParseResponseMessage)
                return
            }
            
            if let response = Parser.shared.parseLatest(safeJson) {
                CALog.shared.logRaw(response)
                completion(response, nil)
            } else {
                completion(nil, NetworkError.server(message: couldNotParseResponseMessage))
            }
        }
    }
}
