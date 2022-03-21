//
//  
//  AndesDiscountViewDefault.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import Foundation

class AndesMoneyAmountDiscountViewDefault: AndesMoneyAmountDiscountAbstractView {

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesDiscountViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
