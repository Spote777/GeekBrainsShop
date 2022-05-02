//
//  GetGoodRequestFactory.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 02.05.2022.
//

import Foundation
import Alamofire

protocol GetGoodRequestFactory {
    func getGood(productId: Int, completionHandler: @escaping (AFDataResponse<Good>) -> Void)
}
