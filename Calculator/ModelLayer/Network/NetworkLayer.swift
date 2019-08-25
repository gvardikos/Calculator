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
    func convert(
        from: String,
        to: String,
        amount: String,
        completion: @escaping NetworkResult) {
        
        fcRequest(Router.convert(from, to, amount)) { (jsonData, error) in
            if let err = error {
                CALog.shared.logRaw(err)
                return
            }
            
            CALog.shared.logRaw(jsonData)
        }
    }
}
