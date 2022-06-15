//
//  GoodResponse.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 02.05.2022.
//

import Foundation

struct GoodResponse: Codable {
    let result: Int?
    let productId: Int?
    let productName: String?
    let price: Int?
    let description: String?
    let picUrl: String?
}
