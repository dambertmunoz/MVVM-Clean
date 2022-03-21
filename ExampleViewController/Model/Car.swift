//
//  Car.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import Foundation

// 1. Codable
    // 1.1 Decodable
    // 1.2 Encodable

class Car: Decodable {

    // MARK: Properties
    var name: String
    var des: String
    var price: Double?

    // MARK: Inits
    init(name: String, des: String) {
        self.name = name
        self.des = des
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name  = try container.decode(String.self, forKey: .name)
        des  = try container.decode(String.self, forKey: .des)
        price = try container.decodeIfPresent(Double.self, forKey: .price)
    }
}

extension Car {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case des = "des"
        case price = "price"
    }
}
