//
//  
//  AndesMoneyAmount.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

@objc public class AndesMoneyAmount: UIView, AndesAccessibleView {
    internal var contentView: AndesMoneyAmountView!
    var accessibilityManager: AndesAccessibilityManager?

    @objc public var size: AndesMoneyAmountSize = .size16 {
        didSet {
            updateContentView()
        }
    }

    @objc public var type: AndesMoneyAmountType = .positive {
        didSet {
            updateContentView()
        }
    }

    @objc public var currency: AndesMoneyAmountCurrency = .BRL {
        didSet {
            updateContentView()
        }
    }

    /// This country variable is used if you want to give a specific format of a site
    @objc public var country: AndesCountry = .DEFAULT {
        didSet {
            updateContentView()
        }
    }

    @objc public var decimalStyle: AndesMoneyAmountDecimalStyle = .normal {
        didSet {
            updateContentView()
        }
    }

    public var amount: Double? = nil {
        didSet {
            if let amount = amount, amount < 0 {
                self.type = .negative
            }

            updateContentView()
        }
    }

    @objc public var amountObjc: NSNumber? = nil {
        didSet {
            if let amountUnwraped = amountObjc as? Double {
                amount = amountUnwraped
            }
        }
    }

    /// adds two zeros in the decimal part of the number ejm: 123.00
    @objc public var showZerosDecimal: Bool = false {
        didSet {
            updateContentView()
        }
    }

    public static func currencyId(_ value: String) -> AndesMoneyAmountCurrency? {
        AndesMoneyAmountCurrency.init(value)
    }

    func moneyAmountCurrencyInfo(for currency: AndesMoneyAmountCurrency, and country: AndesCountry) -> AndesCurrencyInfo? {
        guard  let currencyInfo = AndesCurrenciesManager.currencies.currencies[currency.toString()] else { return nil}

        return currencyInfo.currencyInfoWith(formatedCountry: country)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(type: AndesMoneyAmountType) {
        super.init(frame: .zero)
        self.type = type
        setup()
    }

    public init(type: AndesMoneyAmountType, size: AndesMoneyAmountSize, currency: AndesMoneyAmountCurrency, decimalStyle: AndesMoneyAmountDecimalStyle, amount: Double?) {
        super.init(frame: .zero)
        self.type = type
        self.size = size
        self.currency = currency
        self.decimalStyle = decimalStyle
        self.amount = amount
        setup()
    }

    @objc public init(type: AndesMoneyAmountType, size: AndesMoneyAmountSize, currency: AndesMoneyAmountCurrency, decimalStyle: AndesMoneyAmountDecimalStyle, amountObjc: NSNumber?) {
        super.init(frame: .zero)
        self.type = type
        self.size = size
        self.currency = currency
        self.decimalStyle = decimalStyle
        self.amountObjc = amountObjc
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
        accessibilityManager = AndesMoneyAmountAccessibilityManager(view: self)
    }

    private func drawContentView(with newView: AndesMoneyAmountView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    @objc public func setAmountValue(intValue: Int, cents: Int) {
        guard let doubleValue = Double("\(intValue).\(cents)") else { return }
        amount = doubleValue
    }

    private func updateContentView() {
        guard let currencyInfo = moneyAmountCurrencyInfo(for: currency, and: country) else { return }

        let config = AndesMoneyAmountViewConfigFactory.provideInternalConfig(type: type, currencyInfo: currencyInfo, size: size, decimalStyle: decimalStyle, amount: amount, showZerosDecimal: showZerosDecimal)
        contentView.update(withConfig: config)
        accessibilityManager?.viewUpdated()
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesMoneyAmountView {
        guard let currencyInfo = moneyAmountCurrencyInfo(for: currency, and: country) else { return AndesMoneyAmountViewDefault(withConfig: AndesMoneyAmountViewConfig()) }

        let config = AndesMoneyAmountViewConfigFactory.provideInternalConfig(type: type, currencyInfo: currencyInfo, size: size, decimalStyle: decimalStyle, amount: amount, showZerosDecimal: showZerosDecimal)
        return AndesMoneyAmountViewDefault(withConfig: config)
    }
}
