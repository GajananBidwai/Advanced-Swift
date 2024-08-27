//
//  ProductDetailsViewController.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import UIKit
import Kingfisher
class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productDetailsTableView: UITableView!
    var product: Data?
    var productId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        initializeTableView()
        NavigationBarConfiguration.setupNavigationBar(for: self, withTitle: "Product Details")
    }
    func registerTableView(){
        let uiNib = UINib(nibName: "ProductImageTableViewCell", bundle: nil)
        productDetailsTableView.register(uiNib, forCellReuseIdentifier: "ProductImageTableViewCell")
        
        let uinib = UINib(nibName: "ProductDetailsTableViewCell", bundle: nil)
        productDetailsTableView.register(uinib, forCellReuseIdentifier: "ProductDetailsTableViewCell")
        
    }
    func initializeTableView(){
        productDetailsTableView.delegate = self
        productDetailsTableView.dataSource = self
        
        productDetailsTableView.delegate = self
        productDetailsTableView.dataSource = self
    }
}
extension ProductDetailsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 250.0
        }else{
            return UITableView.automaticDimension
        }
    }
}
extension ProductDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let productImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductImageTableViewCell", for: indexPath) as! ProductImageTableViewCell
            let image = product?.product_images
            let imageString = URL(string: image!)
            productImageTableViewCell.productImage.kf.setImage(with: imageString)
            productImageTableViewCell.selectionStyle = .none
            return productImageTableViewCell
        }else{
            let productDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTableViewCell", for: indexPath) as! ProductDetailsTableViewCell
            productDetailsTableViewCell.productNameLabel.text = product?.name
            productDetailsTableViewCell.productPriceLabel.text = "Rs.\(String(describing: product!.cost))"
            productDetailsTableViewCell.productProducerLabel.text = product?.producer
            productDetailsTableViewCell.productRatingLabel.text = "Rating \(String(describing: product!.rating))"
            productDetailsTableViewCell.productDescriptionlabel.text = product?.description
            
            let wishlistStatus = product?.isWishlisted ?? false
            productDetailsTableViewCell.wishListBtn.setImage(UIImage(named: wishlistStatus ? "heart.fill": "heart"), for: .normal)
            productDetailsTableViewCell.wishListBtn.addTarget(self, action: #selector(addToWishList), for: .touchUpInside)
            productDetailsTableViewCell.selectionStyle = .none
            return productDetailsTableViewCell
        }
    }
    @objc func addToWishList(){
        guard let id = product?.id,
              let wishListStatus = product?.isWishlisted else { return}
        if wishListStatus{
            CoreDataHelper.shared.deleteProduct(id: id)
            
        }else{
            CoreDataHelper.shared.saveProductDataToCoreData(id: id)
        }
        productDetailsTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
}

