//
//  MainCoordinator.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {

        let vc = CarViewController.instance()
        vc.viewModel = CarViewModel()
        vc.coordinator = CarViewCoordinator(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
