//
//  
//  AndesDiscountViewConfig.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import Foundation

/// used to define the ui of internal AndesDiscount views
internal struct AndesMoneyAmountDiscountViewConfig {
    var discountValue: Int?
    var size: AndesMoneyAmountSize?
    init() {}

    init(discountValue: Int, size: AndesMoneyAmountSize) {
        self.discountValue = discountValue
        self.size = size
    }
}
