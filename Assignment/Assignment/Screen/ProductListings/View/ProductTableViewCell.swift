//
//  ProductTableViewCell.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productProducerLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var wishlistBtn: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
}

