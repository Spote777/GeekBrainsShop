//
//  SignupRequestFactory.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 24.04.2022.
//

import Foundation
import Alamofire

protocol SignupRequestFactory {
    func signup(user: User, completionHandler: @escaping (AFDataResponse<SignupResult>) -> Void)
}
