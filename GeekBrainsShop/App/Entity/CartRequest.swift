//
//  CartRequest.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 21.05.2022.
//

import Foundation

struct CartRequest: Codable {
    var productId: Int?
    var quantity: Int?
}
