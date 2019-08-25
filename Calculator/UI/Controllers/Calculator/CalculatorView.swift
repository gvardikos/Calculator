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
    
    private var calculatorButton = CAButton(title: "AC", backgroundColor: orangeButtonColor)
    private var calculatorButton2 = CAButton(title: "+/-", backgroundColor: orangeButtonColor)
    private var calculatorButton3 = CAButton(title: "%", backgroundColor: orangeButtonColor)
    private var calculatorButton4 = CAButton(title: "/", backgroundColor: orangeButtonColor)
    
    private var calculatorButton5 = CAButton(title: "7", backgroundColor: .gray)
    private var calculatorButton6 = CAButton(title: "8", backgroundColor: .gray)
    private var calculatorButton7 = CAButton(title: "9", backgroundColor: .gray)
    private var calculatorButton8 = CAButton(title: "x", backgroundColor: orangeButtonColor)
    
    private var calculatorButton9 = CAButton(title: "4", backgroundColor: .gray)
    private var calculatorButton10 = CAButton(title: "5", backgroundColor: .gray)
    private var calculatorButton11 = CAButton(title: "6", backgroundColor: .gray)
    private var calculatorButton12 = CAButton(title: "-", backgroundColor: orangeButtonColor)
    
    private var calculatorButton13 = CAButton(title: "1", backgroundColor: .gray)
    private var calculatorButton14 = CAButton(title: "2", backgroundColor: .gray)
    private var calculatorButton15 = CAButton(title: "3", backgroundColor: .gray)
    private var calculatorButton16 = CAButton(title: "+", backgroundColor: orangeButtonColor)
    
    private var calculatorButton17 = CAButton(title: "0", backgroundColor: .gray)
    private var calculatorButton18 = CAButton(title: ",", backgroundColor: .gray)
    private var calculatorButton20 = CAButton(title: "=", backgroundColor: orangeButtonColor)
    
    override func addSubviewsWithSvh() {
        displayView.sv([displayLabel])
        
        hRowStacjViewOne.addArrangedSubview(calculatorButton)
        hRowStacjViewOne.addArrangedSubview(calculatorButton2)
        hRowStacjViewOne.addArrangedSubview(calculatorButton3)
        hRowStacjViewOne.addArrangedSubview(calculatorButton4)
        
        hRowStacjViewTwo.addArrangedSubview(calculatorButton5)
        hRowStacjViewTwo.addArrangedSubview(calculatorButton6)
        hRowStacjViewTwo.addArrangedSubview(calculatorButton7)
        hRowStacjViewTwo.addArrangedSubview(calculatorButton8)
        
        hRowStacjViewThree.addArrangedSubview(calculatorButton9)
        hRowStacjViewThree.addArrangedSubview(calculatorButton10)
        hRowStacjViewThree.addArrangedSubview(calculatorButton11)
        hRowStacjViewThree.addArrangedSubview(calculatorButton12)
        
        hRowStacjViewFour.addArrangedSubview(calculatorButton13)
        hRowStacjViewFour.addArrangedSubview(calculatorButton14)
        hRowStacjViewFour.addArrangedSubview(calculatorButton15)
        hRowStacjViewFour.addArrangedSubview(calculatorButton16)
        
        hRowStacjViewFive.addArrangedSubview(calculatorButton17)
        hRowStacjViewFive.addArrangedSubview(calculatorButton18)
        hRowStacjViewFive.addArrangedSubview(calculatorButton20)

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
        
        calculatorButton17.Width == hRowStacjViewFive.Width * 1/2 - 0.5
        calculatorButton18.Width == calculatorButton20.Width
    }
}
