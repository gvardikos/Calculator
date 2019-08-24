//
//  CALog.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Foundation

final class CALog {
    static  let shared = CALog()
    
    private init() {}
    
    public func log(message: String) {
        print("\(#function): \(message)")
    }
    
    public func logRaw(_ obj: Any) {
        print(obj)
    }
}
