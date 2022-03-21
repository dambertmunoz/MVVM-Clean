//
//  CarRepository.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 15/03/22.
//

import Foundation
import Alamofire

protocol CarRepositoryProtocol {
    func getCar() -> Car
    func addCar(car: Car)
    func list(completion: @escaping (Result<[Car], NetworkError>) -> Void)
}

class CarRepository: CarRepositoryProtocol {

    var arrCar: [Car] = []
    public init() {

    }

    func getCar() -> Car { // index
        
        // Call URL Session , API1
        return Car(name: "Toyota", des: "123")
    }

    func addCar(car: Car) {
        arrCar.append(car)
    }

    func list(completion: @escaping (Result<[Car], NetworkError>) -> Void) {

        let request = AF.request("https://demo0573232.mockable.io/cars")

        request.responseDecodable(of: [Car].self) { (response) in
          guard let cars = response.value else {
              return completion(.failure(.badDecodable))
          }
            completion(.success(cars))
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//
//            }
        }
//        let cars: [Car] = loadJSONFrom("cars.json")
//        return cars

    }

    // 1. AF with parameters POST , GET
    // 2. AF hacer la casuisticas del header con token. JWT


}
