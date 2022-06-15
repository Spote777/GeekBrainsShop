//
//  CatalogTableViewCell.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 31.05.2022.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - System cell override func 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Configuration func
    
    func configurationCell(model: CatalogResponse) {
        titleLabel.text = model.productName
        descriptionLabel.text = model.shortDescription
        priceLabel.text = "\(model.price ?? 0) руб."
        guard let url = URL(string: model.picUrl ?? "") else { return }
        itemImage.downloaded(from: url)
    }
}
