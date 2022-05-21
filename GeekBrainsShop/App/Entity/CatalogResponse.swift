//
//  CatalogResponse.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 02.05.2022.
//

import Foundation

struct CatalogResponse: Codable {
    let productId: Int?
    let productName: String?
    let price: Int?
}
