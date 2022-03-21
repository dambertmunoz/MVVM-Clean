//
//  
//  AndesMoneyAmountDiscountViewDefault.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

class AndesMoneyAmountViewDefault: AndesMoneyAmountAbstractView {
    override func loadNib() {
        AndesBundle.bundle().loadNibNamed("AndesMoneyAmountViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
