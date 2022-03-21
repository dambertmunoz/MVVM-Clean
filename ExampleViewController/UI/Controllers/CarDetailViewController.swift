//
//  CarDetailViewController.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import UIKit

class CarDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var carDataView: AlkemyCarDataView!

    var viewModel: CarDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(viewModel?.car.name ?? "")
    }

    func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        carDataView.setupData(car: viewModel.car)
    }
}
