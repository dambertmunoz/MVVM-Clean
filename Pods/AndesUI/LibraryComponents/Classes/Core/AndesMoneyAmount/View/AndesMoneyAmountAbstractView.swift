//
//  
//  AndesMoneyAmountAbstractView.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import UIKit

class AndesMoneyAmountAbstractView: UIView, AndesMoneyAmountView {
    @IBOutlet private weak var componentView: UIView!
    @IBOutlet weak var label: UILabel!

    var config: AndesMoneyAmountViewConfig
    init(withConfig config: AndesMoneyAmountViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesMoneyAmountViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesMoneyAmountViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    func updateView() {
        guard let amountItems = separateDecimals() else { return }

        let andesFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: config.labelSize)

        var amountValue = config.decimalStyle == .none ? amountItems.integer : config.amount
        amountValue = config.type == .negative ? "- " + amountValue : amountValue

        var attributedAmount =  NSMutableAttributedString(string: amountValue, attributes: [.font: andesFont])

        label.textColor = config.type != .previous ? AndesStyleSheetManager.styleSheet.textColorPrimary : AndesStyleSheetManager.styleSheet.textColorSecondary

        if config.type == .previous {
            let previousAttString = setUpPrevious(with: attributedAmount, amount: amountValue)
            attributedAmount = previousAttString
        }

        if config.decimalStyle == .superScript, amountItems.decimal != "" {
            let superScriptAttString = configureSuperScript(attString: attributedAmount, amount: amountValue)
            attributedAmount = superScriptAttString
            if config.type == .previous {
                let previousAttString = setUpPrevious(with: attributedAmount, amount: amountValue)
                attributedAmount = previousAttString
            }
            attributedAmount.replaceCharacters(in: NSRange(location: amountValue.count - 3, length: 1), with: "")
        }

        label.attributedText = attributedAmount
    }

    private func configureSuperScript(attString: NSMutableAttributedString, amount: String) -> NSMutableAttributedString {
        let superScriptAttString = attString
        let andesSuperScriptFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: config.superScriptSize)

        superScriptAttString.setAttributes([.font: andesSuperScriptFont, .baselineOffset: (config.superScriptSize * 0.65)], range: NSRange(location: amount.count - 2, length: 2))
        superScriptAttString.addAttribute(.kern, value: 1, range: NSRange(location: amount.count - 3, length: 1))
        return superScriptAttString
    }

    private func setUpPrevious(with attString: NSMutableAttributedString, amount: String) -> NSMutableAttributedString {
        let previousAttString = attString
        previousAttString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: amount.count - 2, length: 2))

        previousAttString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: amount.count - 2 ))
        return previousAttString
    }

    private func separateDecimals() -> (integer: String, decimal: String)? {
        var amountItems: (integer: String, decimal: String) = ("", "")

        let separator = CharacterSet(charactersIn: config.decimalSeparator)
        let arrayOfAmountItems = config.amount.components(separatedBy: separator)

        if let firstItem = arrayOfAmountItems.first,
           let lastItem = arrayOfAmountItems.last {
            amountItems = (firstItem, firstItem == lastItem ? "" : lastItem)
        }

        return amountItems
    }
}
