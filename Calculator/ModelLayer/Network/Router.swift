//
//  Router.swift
//  Calculator
//
//  Created by George Vardikos on 25/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    case latest(_ symbols: String)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var path: String {
        return "/latest"
    }
    
    var apiKey: String {
        return API.key
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = API.baseURL
        var request = URLRequest(url: url.appendingPathComponent(path))
        var parameters = [String: String]()
        
        request.httpMethod = self.httpMethod.rawValue
        
        switch self {
        case .latest(let symbols):
            parameters.updateValue(apiKey, forKey: accessKeyKeyword)
            parameters.updateValue(symbols, forKey: symbolsKeyword)
            
            request = try URLEncoding.default.encode(request, with: parameters)
        }

        CALog.shared.logRaw("[CARequest]: \(request)")
        return request
    }
}
