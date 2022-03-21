//
//  
//  AndesDiscountAbstractView.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import UIKit

class AndesMoneyAmountDiscountAbstractView: UIView, AndesMoneyAmountDiscountView {
    @IBOutlet weak var componentView: UIView!
    @IBOutlet weak var discountLabel: UILabel!

    var config: AndesMoneyAmountDiscountViewConfig
    init(withConfig config: AndesMoneyAmountDiscountViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesMoneyAmountDiscountViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesMoneyAmountDiscountViewConfig) {
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

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        guard let configSizeString = config.size,
              let size = getSizeFor(configSizeString, isForSuperScript: false) else { return }
        discountLabel.font = discountLabel.font.withSize(size)
        discountLabel.text = "\(config.discountValue ?? 0)% OFF"
        discountLabel.textColor = AndesStyleSheetManager.styleSheet.textColorPositive
    }

    private func getSizeFor(_ size: AndesMoneyAmountSize, isForSuperScript: Bool) -> CGFloat? {
        let sizeString = AndesMoneyAmountSize.keyFor(size)
        guard let size = NumberFormatter().number(from: sizeString) else {return nil}
        return CGFloat(truncating: size)
    }
}
