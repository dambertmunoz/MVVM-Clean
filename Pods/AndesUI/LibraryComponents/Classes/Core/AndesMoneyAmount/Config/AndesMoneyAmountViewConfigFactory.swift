//
//  
//  AndesMoneyAmountViewConfigFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

internal class AndesMoneyAmountViewConfigFactory {
    static func provideInternalConfig(type: AndesMoneyAmountType, currencyInfo: AndesCurrencyInfo, size: AndesMoneyAmountSize, decimalStyle: AndesMoneyAmountDecimalStyle, amount: Double?, showZerosDecimal: Bool) -> AndesMoneyAmountViewConfig {
        let amount = amount ?? 0
        let amountFormated = "\(currencyInfo.symbol) \(AndesMoneyAmountCurrencyFactory.provide(currencyInfo, decimalStyle, amount: amount < 0 ? abs(amount) : amount, showZerosDecimal: showZerosDecimal))"

        func getSizeFor(_ size: AndesMoneyAmountSize, isForSuperScript: Bool) -> CGFloat {
            let sizeString = AndesMoneyAmountSize.keyFor(size)

            if isForSuperScript, decimalStyle == .superScript {
                let superScriptSize = AndesMoneyAmountSize.superScriptSizeFor(size)
                return superScriptSize
            }

            guard let size = NumberFormatter().number(from: sizeString) else {return 0.0}

            return CGFloat(truncating: size)
        }

        let config = AndesMoneyAmountViewConfig(type: type, decimalStyle: decimalStyle, decimalSeparator: currencyInfo.decimalSeparator, amount: amountFormated, labelSize: getSizeFor(size, isForSuperScript: false), superScripSize: getSizeFor(size, isForSuperScript: true))

        return config
    }
}
