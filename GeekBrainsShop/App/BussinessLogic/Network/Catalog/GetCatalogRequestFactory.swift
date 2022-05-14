//
//  GetCatalogRequestFactory.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 02.05.2022.
//

import Foundation
import Alamofire

protocol GetCatalogRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[Catalog]>) -> Void)
}
