//
//  
//  AndesDiscountViewConfigFactory.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import Foundation

internal class AndesMoneyAmountDiscountViewConfigFactory {
    static func provideInternalConfig(discountValue: Int, size: AndesMoneyAmountSize) -> AndesMoneyAmountDiscountViewConfig {
        let config = AndesMoneyAmountDiscountViewConfig(discountValue: discountValue, size: size)
        return config
    }
}
