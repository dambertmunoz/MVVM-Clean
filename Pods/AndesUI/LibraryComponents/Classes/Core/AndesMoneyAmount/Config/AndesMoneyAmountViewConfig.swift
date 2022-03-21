//
//  
//  AndesMoneyAmountViewConfig.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

/// used to define the ui of internal AndesMoneyAmountPrice views
internal struct AndesMoneyAmountViewConfig {
    var type: AndesMoneyAmountType = .positive
    var decimalStyle: AndesMoneyAmountDecimalStyle = .normal
    var decimalSeparator: String = "."
    var amount: String = ""
    var labelSize: CGFloat = 0.0
    var superScriptSize: CGFloat = 0.0

    init() {}

    init(type: AndesMoneyAmountType, decimalStyle: AndesMoneyAmountDecimalStyle, decimalSeparator: String, amount: String, labelSize: CGFloat, superScripSize: CGFloat) {
        self.type = type
        self.decimalStyle = decimalStyle
        self.decimalSeparator = decimalSeparator
        self.amount = amount
        self.labelSize = labelSize
        self.superScriptSize = superScripSize
    }
}
