//
//  AndesPageDotView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 13/04/2021.
//

import UIKit

class AndesPageDotView: UIView {
    override func tintColorDidChange() {
        self.backgroundColor = tintColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }

    override var frame: CGRect {
        didSet {
            updateCornerRadius()
        }
    }

    private func updateCornerRadius() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
