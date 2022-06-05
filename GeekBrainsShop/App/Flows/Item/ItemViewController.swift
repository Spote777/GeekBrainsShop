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
        self.itemNameLabel.text = model.productName
        self.descriptionLabel.text = model.description
        self.itemPriceLabel.text = "\(model.price ?? 0) руб."
        guard let url = URL(string: model.picUrl ?? "") else { return }
        self.itemPic.downloaded(from: url)
    }
}
