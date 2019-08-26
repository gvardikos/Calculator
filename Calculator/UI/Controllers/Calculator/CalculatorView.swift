//
//  CalculatorView.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

final class CalculatorView: BaseView<CalculatorViewModel> {
    lazy var container: UIView = { [unowned self] in
        let v = UIView()
        v.backgroundColor = .yellow
        return v
    }()

    lazy var displayView: UIView = { [unowned self] in
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    
    lazy var buttonsView: UIView = { [unowned self] in
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    
    lazy var displayLabel: UILabel = { [unowned self] in
        let lb = UILabel()
        lb.backgroundColor = .black
        lb.textColor = .white
        lb.text = "0"
        lb.font = UIFont.systemFont(ofSize: 50.0)
        lb.textAlignment = .right
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var verticalStackView: UIStackView = { [unowned self] in
        let hStackView = UIStackView()
        hStackView.axis = .vertical
        hStackView.spacing = 1
        return hStackView
    }()
    
    private var hRowStacjViewOne = CAHorizontalStackView()
    private var hRowStacjViewTwo = CAHorizontalStackView()
    private var hRowStacjViewThree = CAHorizontalStackView()
    private var hRowStacjViewFour = CAHorizontalStackView()
    private var hRowStacjViewFive = CAHorizontalStackView(dist: .fill)
    
    // One
    lazy var CAACButton: CAButton = { [unowned self] in
        let button = CAButton(op: .clear, title: "AC", backgroundColor: orangeButtonColor)
        return button
    }()
    
    lazy var CAPlusMinusButton: CAButton = { [unowned self] in
        let button = CAButton(op: .function, title: "+/-", backgroundColor: orangeButtonColor)
        return button
    }()
    
    lazy var CAPercentButton: CAButton = { [unowned self] in
        let button =  CAButton(op: .function, title: "%", backgroundColor: orangeButtonColor)
        return button
    }()
    
    lazy var CADivideButton: CAButton = { [unowned self] in
        let button = CAButton(op: .function, title: "/", backgroundColor: orangeButtonColor)
        return button
    }()
    
    // Two
    lazy var CASevenButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "7", backgroundColor: .gray)
        return button
    }()
    
    lazy var CAEightButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "8", backgroundColor: .gray)
        return button
    }()
    
    lazy var CANineButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "9", backgroundColor: .gray)
        return button
    }()
    
    lazy var CAMultiButton: CAButton = { [unowned self] in
        let button = CAButton(op: .function, title: "*", backgroundColor: orangeButtonColor)
        return button
    }()
    
    // Three
    lazy var CAFourButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "4", backgroundColor: .gray)
        return button
    }()
    
    lazy var CAFiveButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "5", backgroundColor: .gray)
        return button
    }()
    
    lazy var CASixButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "6", backgroundColor: .gray)
        return button
    }()
    
    lazy var CAMinusButton: CAButton = { [unowned self] in
        let button = CAButton(op: .function, title: "-", backgroundColor: orangeButtonColor)
        return button
        }()
    
    // Four
    lazy var CAOneButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "1", backgroundColor: .gray)
        return button
    }()
    
    lazy var CATwoButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "2", backgroundColor: .gray)
        return button
    }()
    
    lazy var CAThreeButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "3", backgroundColor: .gray)
        return button
    }()
    
    lazy var CAPlusButton: CAButton = { [unowned self] in
        let button = CAButton(op: .function, title: "+", backgroundColor: orangeButtonColor)
        return button
        }()
    
    // Five
    lazy var CAZeroButton: CAButton = { [unowned self] in
        let button = CAButton(op: .number, title: "0", backgroundColor: .gray)
        return button
    }()
    
    lazy var CACommaButton: CAButton = { [unowned self] in
        let button = CAButton(op: .function, title: ",", backgroundColor: .gray)
        return button
    }()
    
    lazy var CAEqualsButton: CAButton = { [unowned self] in
        let button = CAButton(op: .equal, title: "=", backgroundColor: orangeButtonColor)
        return button
    }()
    
    fileprivate lazy var calcButtons: [CAButton] = [CAACButton, CAPlusMinusButton, CAPercentButton, CADivideButton, CASevenButton, CAEightButton, CANineButton, CAMultiButton, CAFourButton, CAFiveButton, CASixButton, CAMinusButton, CAOneButton, CATwoButton, CAThreeButton, CAPlusButton, CAZeroButton, CACommaButton, CAEqualsButton]
    
    override func initialize() {
        addSubviewsWithSvh()
        initContraints()
        
        calcButtons.forEach { (button) in
            button.addTarget(self, action: #selector(handleOperation), for: .touchUpInside)
        }
    }
    
    @objc
    func handleOperation(sender: CAButton) {
        viewModel?.handle(sender)
    }
    
    override func bind() {
        viewModel?.screenText.bind(listener: { [unowned self] (text) in
            self.displayLabel.text? = text
        })
    }
}

extension CalculatorView {
    func addSubviewsWithSvh() {
        displayView.sv([displayLabel])
        
        hRowStacjViewOne.addArrangedSubview(CAACButton)
        hRowStacjViewOne.addArrangedSubview(CAPlusMinusButton)
        hRowStacjViewOne.addArrangedSubview(CAPercentButton)
        hRowStacjViewOne.addArrangedSubview(CADivideButton)
        
        hRowStacjViewTwo.addArrangedSubview(CASevenButton)
        hRowStacjViewTwo.addArrangedSubview(CAEightButton)
        hRowStacjViewTwo.addArrangedSubview(CANineButton)
        hRowStacjViewTwo.addArrangedSubview(CAMultiButton)
        
        hRowStacjViewThree.addArrangedSubview(CAFourButton)
        hRowStacjViewThree.addArrangedSubview(CAFiveButton)
        hRowStacjViewThree.addArrangedSubview(CASixButton)
        hRowStacjViewThree.addArrangedSubview(CAMinusButton)
        
        hRowStacjViewFour.addArrangedSubview(CAOneButton)
        hRowStacjViewFour.addArrangedSubview(CATwoButton)
        hRowStacjViewFour.addArrangedSubview(CAThreeButton)
        hRowStacjViewFour.addArrangedSubview(CAPlusButton)
        
        hRowStacjViewFive.addArrangedSubview(CAZeroButton)
        hRowStacjViewFive.addArrangedSubview(CACommaButton)
        hRowStacjViewFive.addArrangedSubview(CAEqualsButton)
        
        verticalStackView.addArrangedSubview(hRowStacjViewOne)
        verticalStackView.addArrangedSubview(hRowStacjViewTwo)
        verticalStackView.addArrangedSubview(hRowStacjViewThree)
        verticalStackView.addArrangedSubview(hRowStacjViewFour)
        verticalStackView.addArrangedSubview(hRowStacjViewFive)
        
        buttonsView.sv([verticalStackView])
        
        container.sv([displayView, buttonsView])
        sv([container])
    }

    func initContraints() {
        // Containers
        setupContainer()
        setupDisplayView()
        setupButtonsView()
        
        setupDisplayLabel()
        setupVerticalStackView()
        setupHorizontalStackView()
    }
    
    private func setupContainer() {
        container.fillContainer()
    }
    
    private func setupDisplayView() {
        displayView.Top == container.Top
        displayView.Left == container.Left
        displayView.Right == container.Right
        displayView.height(30%)
    }
    
    private func setupDisplayLabel() {
        displayLabel.Bottom == displayView.Bottom
        displayLabel.Left == displayView.Left
        displayLabel.Right == displayView.Right
        displayLabel.height(30%)
    }
    
    private func setupButtonsView() {
        buttonsView.Top == displayLabel.Bottom
        buttonsView.Left == container.Left
        buttonsView.Right == container.Right
        buttonsView.Bottom == container.Bottom
    }
    
    private func setupVerticalStackView() {
        verticalStackView.fillContainer()
    }
    
    private func setupHorizontalStackView() {
        hRowStacjViewOne.Top == buttonsView.Top
        hRowStacjViewOne.Left == buttonsView.Left
        hRowStacjViewOne.Right == buttonsView.Right
        
        hRowStacjViewTwo.Top == hRowStacjViewOne.Bottom
        hRowStacjViewTwo.Left == buttonsView.Left
        hRowStacjViewTwo.Right == buttonsView.Right
        
        hRowStacjViewThree.Top == hRowStacjViewTwo.Bottom
        hRowStacjViewThree.Left == buttonsView.Left
        hRowStacjViewThree.Right == buttonsView.Right
        
        hRowStacjViewFour.Top == hRowStacjViewThree.Bottom
        hRowStacjViewFour.Left == buttonsView.Left
        hRowStacjViewFour.Right == buttonsView.Right
        
        hRowStacjViewFive.Top == hRowStacjViewFour.Bottom
        hRowStacjViewFive.Left == buttonsView.Left
        hRowStacjViewFive.Right == buttonsView.Right
        hRowStacjViewFive.Bottom == buttonsView.Bottom
        
        hRowStacjViewOne.Height == hRowStacjViewTwo.Height
        hRowStacjViewTwo.Height == hRowStacjViewThree.Height
        hRowStacjViewThree.Height == hRowStacjViewFour.Height
        hRowStacjViewFour.Height == hRowStacjViewFive.Height
        
        CAZeroButton.Width == hRowStacjViewFive.Width * 1/2 - 0.5
        CACommaButton.Width == CAEqualsButton.Width
    }
}
