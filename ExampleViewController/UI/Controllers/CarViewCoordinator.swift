//
//  CarViewCoordinator.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import UIKit

class CarViewCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goToDetail(car: Car) {

        let vc = CarDetailViewController.instance()
        vc.viewModel = CarDetailViewModel(car: car)
        navigationController.pushViewController(vc, animated: true)
    }

}
