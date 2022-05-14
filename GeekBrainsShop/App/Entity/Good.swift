//
//  Good.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 02.05.2022.
//

import Foundation

struct Good: Codable {
    let result: Int?
    let price: Int?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case price = "product_price"
        case description = "product_description"
    }
}
