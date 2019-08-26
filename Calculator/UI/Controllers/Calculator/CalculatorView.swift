//
//  CalculatorView.swift
//  Calculator
//
//  Created by George Vardikos on 24/08/2019.
//  Copyright © 2019 George Vardikos. All rights reserved.
//

import Stevia

// TODO: Separate the Views into new files

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
    
    lazy var currencyCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.register(CurrenciesCVCell.self,
                    forCellWithReuseIdentifier: CurrenciesCVCell.reuseIdentifier)
        cv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cv.delegate = self
        cv.dataSource = self
        return cv
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
    private let CAACButton = CAButton(op: .clear, title: "AC", backgroundColor: orangeButtonColor)
    private let CAPlusMinusButton = CAButton(op: .minusPlus, title: "+/-", backgroundColor: orangeButtonColor)
    private let CAPercentButton =  CAButton(op: .percent, title: "%", backgroundColor: orangeButtonColor)
    private let CADivideButton = CAButton(op: .function, title: "/", backgroundColor: orangeButtonColor)
    
    // Two
    private let CASevenButton = CAButton(op: .number, title: "7", backgroundColor: .gray)
    private let CAEightButton = CAButton(op: .number, title: "8", backgroundColor: .gray)
    private let CANineButton = CAButton(op: .number, title: "9", backgroundColor: .gray)
    private let CAMultiButton = CAButton(op: .function, title: "*", backgroundColor: orangeButtonColor)
    
    // Three
    private let CAFourButton = CAButton(op: .number, title: "4", backgroundColor: .gray)
    private let CAFiveButton = CAButton(op: .number, title: "5", backgroundColor: .gray)
    private let CASixButton = CAButton(op: .number, title: "6", backgroundColor: .gray)
    private let CAMinusButton = CAButton(op: .function, title: "-", backgroundColor: orangeButtonColor)

    // Four
    private let CAOneButton = CAButton(op: .number, title: "1", backgroundColor: .gray)
    private let CATwoButton = CAButton(op: .number, title: "2", backgroundColor: .gray)
    private let CAThreeButton = CAButton(op: .number, title: "3", backgroundColor: .gray)
    private let CAPlusButton = CAButton(op: .function, title: "+", backgroundColor: orangeButtonColor)

    // Five
    private let CAZeroButton = CAButton(op: .number, title: "0", backgroundColor: .gray)
    private let CACommaButton = CAButton(op: .number, title: ".", backgroundColor: .gray)
    private let CAEqualsButton = CAButton(op: .equal, title: "=", backgroundColor: orangeButtonColor)
    
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
        
        viewModel?.currencyData.bind(listener: { (_) in
            self.currencyCollectionView.reloadData()
        })
    }
}

extension CalculatorView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3.5 - 16
        let height: CGFloat = displayView.frame.height * 0.20
        
        return CGSize(width: width, height: CGFloat(height))
    }
}

extension CalculatorView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.currencyData.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = currencyCollectionView.dequeueReusableCell(
            withReuseIdentifier: CurrenciesCVCell.reuseIdentifier,
            for: indexPath) as? CurrenciesCVCell else { return UICollectionViewCell() }
        
        let rateDict = viewModel?.currencyData.value[indexPath.item] ?? [:]
        cell.setup(viewModel: CurrencyCellViewModel(rate: rateDict))
        return cell
    }
}

extension CalculatorView {
    func addSubviewsWithSvh() {
        displayView.sv([currencyCollectionView, displayLabel])
        
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
        
        setupCurrencyCollectionView()
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
    
    private func setupCurrencyCollectionView() {
        currencyCollectionView.Top == safeAreaLayoutGuide.Top
        currencyCollectionView.Left == displayView.Left
        currencyCollectionView.Right == displayView.Right
        currencyCollectionView.Bottom == displayLabel.Top
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
