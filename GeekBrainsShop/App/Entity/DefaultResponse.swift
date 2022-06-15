//
//  DefaultResponse.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 14.05.2022.
//

import Foundation

struct DefaultResponse: Codable {
     var result: Int
     var successMessage: String?
     var errorMessage: String?
 }
