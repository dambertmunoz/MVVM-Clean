//
//  
//  AndesDiscount.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import Foundation

@objc public class AndesMoneyAmountDiscount: UIView, AndesAccessibleView {
    internal var contentView: AndesMoneyAmountDiscountView!

    @objc public var discountValue: Int = 0 {
        didSet {
            if discountValue < 0 {
                self.discountValue = abs(discountValue)
            }

            if discountValue > 100 {
                self.discountValue = 100
            }

            updateContentView()
        }
    }

    @objc public var size: AndesMoneyAmountSize = .size12 {
        didSet {
            updateContentView()
        }
    }

    var accessibilityManager: AndesAccessibilityManager?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(discountValue: Int, size: AndesMoneyAmountSize) {
        super.init(frame: .zero)
        self.discountValue = discountValue
        self.size = size
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
        accessibilityManager = AndesMoneyAmountDiscountAccesibilityManager(view: self)
    }

    private func drawContentView(with newView: AndesMoneyAmountDiscountView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateContentView() {
        let config = AndesMoneyAmountDiscountViewConfigFactory.provideInternalConfig(discountValue: discountValue, size: size)
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesMoneyAmountDiscountView {
        let config = AndesMoneyAmountDiscountViewConfigFactory.provideInternalConfig(discountValue: discountValue, size: size)
        return AndesMoneyAmountDiscountViewDefault(withConfig: config)
    }
}

// MARK: - IB interface
public extension AndesMoneyAmountDiscount {
    @IBInspectable var ibSize: String {
        set(val) {
            self.size = AndesMoneyAmountSize.checkValidEnum(property: "IB size", key: val)
        }
        get {
            return self.size.toString()
        }
    }

    @IBInspectable var ibDiscount: Int {
        set(val) {
            self.discountValue = val
        }
        get {
            return self.discountValue
        }
    }
}
