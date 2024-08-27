//
//  ProductDetailsTableViewCell.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import UIKit

class ProductDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productProducerLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productRatingLabel: UILabel!
    @IBOutlet weak var productDescriptionlabel: UILabel!
    @IBOutlet weak var wishListBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
}
