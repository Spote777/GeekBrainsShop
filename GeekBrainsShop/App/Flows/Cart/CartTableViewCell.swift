//
//  CartTableViewCell.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 07.06.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var delegate: CartDelegate?
    var row: Int?
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let row = row else { return }
        delegate?.deleteItem(row)
    }
    
    func configure(_ item: AppCartItem) {
        productName.text = item.productName
        productPrice.text = "\(item.price ?? 0) ₽"
        guard let url = URL(string: item.picUrl ?? "") else { return }
        productImage.downloaded(from: url)
    }
}
