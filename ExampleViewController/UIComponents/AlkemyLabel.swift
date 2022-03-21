//
//  AlkemyLabel.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import UIKit

class AlkemyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = .lightGray
        self.textColor = .black
    }

}
