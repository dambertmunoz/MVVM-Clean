//
//  AlkemyCarDataView.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import UIKit

class AlkemyCarDataView: UIView {

    @IBOutlet weak var nameLabel: AlkemyLabel!
    @IBOutlet weak var detailLabel: AlkemyLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        let view = self.loadNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        view.backgroundColor = .blue
    }

    func setupData(car: Car) {
        nameLabel.text = car.name
        detailLabel.text = car.des
    }
    
}
