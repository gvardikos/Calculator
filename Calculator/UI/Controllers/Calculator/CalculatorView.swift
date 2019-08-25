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
    
    private var CAACButton = CAButton(title: "AC", backgroundColor: orangeButtonColor)
    private var CAPlusMinusButton2 = CAButton(title: "+/-", backgroundColor: orangeButtonColor)
    private var CAPercentButton = CAButton(title: "%", backgroundColor: orangeButtonColor)
    private var CADivideButton = CAButton(title: "/", backgroundColor: orangeButtonColor)
    
    private var CASevenButton = CAButton(title: "7", backgroundColor: .gray)
    private var CAEightButton = CAButton(title: "8", backgroundColor: .gray)
    private var CANineButton = CAButton(title: "9", backgroundColor: .gray)
    private var CAMultiButton = CAButton(title: "x", backgroundColor: orangeButtonColor)
    
    private var CAFourButton = CAButton(title: "4", backgroundColor: .gray)
    private var CAFiveButton = CAButton(title: "5", backgroundColor: .gray)
    private var CASixButton = CAButton(title: "6", backgroundColor: .gray)
    private var CAMinusButton = CAButton(title: "-", backgroundColor: orangeButtonColor)
    
    private var CAOneButton = CAButton(title: "1", backgroundColor: .gray)
    private var CATwoButton = CAButton(title: "2", backgroundColor: .gray)
    private var CAThreeButton = CAButton(title: "3", backgroundColor: .gray)
    private var CAPlusButton = CAButton(title: "+", backgroundColor: orangeButtonColor)
    
    private var CAZeroButton = CAButton(title: "0", backgroundColor: .gray)
    private var CACommaButton = CAButton(title: ",", backgroundColor: .gray)
    private var CAEqualsButton = CAButton(title: "=", backgroundColor: orangeButtonColor)
    
    override func addSubviewsWithSvh() {
        displayView.sv([displayLabel])
        
        hRowStacjViewOne.addArrangedSubview(CAACButton)
        hRowStacjViewOne.addArrangedSubview(CAPlusMinusButton2)
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
    
    override func initStyle() {
        
    }
    
    override func initContraints() {
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
