//
//  AuthRequestFactory.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 24.04.2022.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    func logout(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}
