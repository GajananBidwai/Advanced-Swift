//
//  ProductViewController.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import UIKit

class ProductViewController: UIViewController {
    
    private let viewModel = ProductViewModel()
    var product: Product?
    var selectedIndex: Int?
    @IBOutlet weak var productTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        NavigationBarConfiguration.setupNavigationBar(for: self, withTitle: "Products")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
    }
    override func viewWillAppear(_ animated: Bool) {
        productTabelView.reloadData()
    }
}
extension ProductViewController{
    func configuration(){
        initViewModel()
        observeEvent()
        registerXIBWithTableView()
        initializeTableView()
    }
    func initViewModel(){
        viewModel.fetchProduct()
    }
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else{ return}
            switch event{
            case .Loading:
                print("Start loading")
            case .StopLoading:
                print("Stop Loading")
            case .DataLoaded:
                product = viewModel.product
                print(self.viewModel.product)
                DispatchQueue.main.async {
                    self.productTabelView.reloadData()
                }
            case .Error(let error):
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    func registerXIBWithTableView(){
        let uiNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTabelView.register(uiNib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    func initializeTableView(){
        productTabelView.delegate = self
        productTabelView.dataSource = self
    }
}
extension ProductViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsViewController = self.storyboard?.instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productDetailsViewController.product = viewModel.product?.data[indexPath.row]
        
        selectedIndex = indexPath.row
        productTabelView.reloadData()
        navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
}
extension ProductViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.product?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productTableViewCell = self.productTabelView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        productTableViewCell.productNameLabel.text = product?.data[indexPath.row].name
        productTableViewCell.productPriceLabel.text = "Rs. \(String(describing: product!.data[indexPath.row].cost))"
        productTableViewCell.productProducerLabel.text = product?.data[indexPath.row].producer
        productTableViewCell.productImageView.setImage(with: product!.data[indexPath.row].product_images)
        let wishlistStatus = product?.data[indexPath.row].isWishlisted ?? false
        productTableViewCell.wishlistBtn.setImage(UIImage(named: wishlistStatus ? "heart.fill": "heart"), for: .normal)
        productTableViewCell.wishlistBtn.tag = indexPath.row
        productTableViewCell.wishlistBtn.addTarget(self, action: #selector(addToWishList), for: .touchUpInside)
        productTableViewCell.selectionStyle = .none
        return productTableViewCell
    }
    
    @objc func addToWishList(_ sender: UIButton){
        let index = sender.tag
        
        guard let id = product?.data[index].id,
              let wishlist = product?.data[index].isWishlisted else {
            return
        }
        
        if wishlist{
            CoreDataHelper.shared.deleteProduct(id: id)
        }else{
            CoreDataHelper.shared.saveProductDataToCoreData(id: id)
        }
        
        productTabelView.reloadData()
    }
}
