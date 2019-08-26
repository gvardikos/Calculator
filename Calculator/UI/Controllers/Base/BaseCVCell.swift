//
//  BaseCVCell.swift
//  Calculator
//
//  Created by George Vardikos on 26/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import UIKit

class BaseCVCell: UICollectionViewCell {
    var index: Int?
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        
    }
}
