//
//  CalculatorButton.swift
//  Calculator
//
//  Created by George Vardikos on 25/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

enum OperatorType {
    case number, equal, clear, function
}

final class CAButton: UIButton {
    var operationType: OperatorType
    var operation: String
    
    convenience init(op: OperatorType, title: String, backgroundColor: UIColor) {
        self.init(type: .system)
        operationType = op
        operation = title
        initialize(op, title, backgroundColor)
    }
    
    override init(frame: CGRect) {
        operationType = .function
        operation = ""
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(_ op: OperatorType = .function, _ title: String = "7", _ backColor: UIColor = .white) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = backColor
        
        let text = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 40)!,
                         NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.setAttributedTitle(text, for: .normal)
        self.layer.cornerRadius = 3
    }
}

extension CAButton {
    func zoomIn(duration: TimeInterval = 0.1) {
        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
