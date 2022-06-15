//
//  AppCart.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 07.06.2022.
//

import Foundation

class AppCart {
    static let shared = AppCart()
    init(){}
    
    var items: [AppCartItem] = []
}
