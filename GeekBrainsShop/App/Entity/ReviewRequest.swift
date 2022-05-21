//
//  ReviewRequest.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 21.05.2022.
//

import Foundation

struct ReviewRequest: Codable {
    let reviewText: String?
    let userId: Int?
    let productId: Int?
}
