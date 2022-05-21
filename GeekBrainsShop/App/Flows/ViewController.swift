//
//  ViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 20.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeAuthRequest()
        makeSignupRequest()
        makeChangeUserDataRequest()
        makeGetCatalogRequest()
        makeGetGoodRequest()
        makeLogoutRequest()
        makeGetReviewsRequest()
        makeAddReviewRequest()
        makeRemoveReviewRequest()
        makeGetCartRequest()
        makePayCartRequest()
        makeAddToCartRequest()
        makeDeleteFromCartRequest()
    }
    
    // MARK: - Methods for testing purposes.
    
    func makeAuthRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(login: "Somebody", password: "mypassword")
        
        factory.login(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeSignupRequest() {
        let factory = requestFactory.makeSignupRequestFactory()
        let user = User(login: "Somebody1",
                        password: "mypassword",
                        email: "test@gmail.com",
                        gender: "m",
                        creditCard: "1234-1234-1234-1234-1234",
                        bio: "nothing",
                        name: "Mike",
                        lastname: "Johnson")
        
        factory.signup(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeChangeUserDataRequest() {
        let factory = requestFactory.makeChangeUserDataRequestFactory()
        let user = User(id: 123,
                        login: "Somebody1",
                        password: "mypassword",
                        email: "test@gmail.com",
                        gender: "m",
                        creditCard: "1234-1234-1234-1234-1234",
                        bio: "nothing",
                        name: "Mike",
                        lastname: "Johnson")
        
        factory.changeUserData(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeLogoutRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(id: 123)
        
        factory.logout(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeGetCatalogRequest() {
        let factory = requestFactory.makeGetCatalogRequestFactory()
        
        factory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeGetGoodRequest() {
        let factory = requestFactory.makeGetGoodRequestFactory()
        
        factory.getGood(productId: 123) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeGetReviewsRequest() {
        let factory = requestFactory.makeReviewsFactory()
        
        factory.getReviews(productId: 123) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeAddReviewRequest() {
        let factory = requestFactory.makeReviewsFactory()
        let review = ReviewRequest(reviewText: "Товар — говно! Не берите!", userId: 123, productId: 666)
        
        factory.addReview(review: review){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeRemoveReviewRequest() {
        let factory = requestFactory.makeReviewsFactory()
        
        factory.removeReview(reviewId: 123){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeGetCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()
        
        factory.getCart(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makePayCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()
        
        factory.payCart(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeAddToCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()
        
        let cart = CartRequest(productId: 666, quantity: 1)
        
        factory.addToCart(cart: cart){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeDeleteFromCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()
        
        let cart = CartRequest(productId: 666)
        
        factory.deleteFromCart(cart: cart){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
