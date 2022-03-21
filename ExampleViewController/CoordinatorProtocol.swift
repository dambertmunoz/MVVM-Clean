//
//  CoordinatorProtocol.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func start() {
        
    }
}
