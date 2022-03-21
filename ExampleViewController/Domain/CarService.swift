//
//  CarService.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 15/03/22.
//

import Foundation

protocol CarServiceProtocol {

    func getCar() -> Car
    func addCar(car: Car)
    func list(completion: @escaping (Result<[Car], NetworkError>) -> Void)
}

class CarService: CarServiceProtocol {

    // MARK: Properties
    let repository: CarRepositoryProtocol

    // MARK: inits
    init(repository: CarRepositoryProtocol = CarRepository()) {
        self.repository = repository
    }

    func getCar() -> Car {
        return repository.getCar()
    }
    func addCar(car: Car) {
        repository.addCar(car: car)
    }
    func list(completion: @escaping (Result<[Car], NetworkError>) -> Void) {
        repository.list(completion: completion)
    }


}
