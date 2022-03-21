//
//  ViewModel.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import Foundation

class CarViewModel {

    // MARK: Properties
    let service: CarServiceProtocol

    // MARK: Inits
    init(service: CarServiceProtocol = CarService()) {
        self.service = service
    }
}

// Car operations
extension CarViewModel {
    func addNewCar(name: String, descr: String) {
        service.addCar(car: Car(name: name, des: descr))
    }
}

extension CarViewModel {
    // MARK: Computed properties
    var carExample: Car {
        service.getCar()
    }
}
