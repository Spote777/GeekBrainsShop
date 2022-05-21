//
//  GetGood.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 02.05.2022.
//

import Foundation
import Alamofire

class GetGood: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://arcane-dawn-08830.herokuapp.com/")!

    init(errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension GetGood: GetGoodRequestFactory {
    func getGood(productId: Int, completionHandler: @escaping (AFDataResponse<GoodResponse>) -> Void) {
        let requestModel = GetGood(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GetGood {
    struct GetGood: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getgood"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
}
