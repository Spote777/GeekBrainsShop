//
//  ReviewResponse.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 21.05.2022.
//

import Foundation

struct ReviewResponse: Codable {
    let userId: Int?
    let reviewText: String?
}
