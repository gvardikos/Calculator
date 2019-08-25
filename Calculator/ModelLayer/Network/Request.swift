//
//  Router.swift
//  Calculator
//
//  Created by George Vardikos on 25/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Alamofire

internal enum Router: URLRequestConvertible {
    case convert(_ from: String, _ to: String, _ amount: String)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .convert:
            return .get
        }
    }
    
    var path: String {
        return "/convert"
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
        case .convert(let from, let to, let amount):
            parameters.updateValue(apiKey, forKey: accessKeyKeyword)
            parameters.updateValue(from, forKey: fromKeyword)
            parameters.updateValue(to, forKey: toKeyword)
            parameters.updateValue(amount, forKey: amountKeyword)
            
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        

        CALog.shared.logRaw(request)
        return request
    }
}


