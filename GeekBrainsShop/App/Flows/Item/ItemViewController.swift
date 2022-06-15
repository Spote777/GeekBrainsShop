//
//  ItemViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 05.06.2022.
//

import UIKit

class ItemViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    // MARK: - Propreties
    
    let factory = RequestFactory()
    var productId: Int?
    var product: GoodResponse?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData { good in
            DispatchQueue.main.async {
                self.configureData(model: good)
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func addItemInCart(_ sender: Any) {
        guard let product = product else { return }
        let cartFactory = factory.makeCartRequestFactory()
        let request = CartRequest(productId: product.productId, quantity: 1)
        cartFactory.addToCart(cart: request) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    let item = AppCartItem(productId: product.productId, productName: product.productName, price: product.price, picUrl: product.picUrl)
                    AppCart.shared.items.append(item)
                    self.showAddToCartSuccessAlert()
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Private Func

extension ItemViewController {
    
    private func fetchData(completionHandler: @escaping (GoodResponse) -> Void) {
        guard let productId = productId else { return }
        let goodFactory = factory.makeGetGoodRequestFactory()
        view.showSpinner()
        goodFactory.getGood(productId: productId) { response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.view.dismissSpinner()
                }
                completionHandler(result)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.dismissSpinner()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureData(model: GoodResponse) {
        self.product = model
        self.itemNameLabel.text = model.productName
        self.descriptionLabel.text = model.description
        self.itemPriceLabel.text = "\(model.price ?? 0) руб."
        guard let url = URL(string: model.picUrl ?? "") else { return }
        self.itemPic.downloaded(from: url)
    }
    
    private func showAddToCartSuccessAlert() {
        let alert = UIAlertController(title: "Корзина", message: "Товар успешно добавлен в корзину.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
