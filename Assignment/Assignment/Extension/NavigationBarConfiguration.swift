//
//  NavigationBarConfiguration.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//
import UIKit

class NavigationBarConfiguration{
    static func setupNavigationBar(for viewController: UIViewController, withTitle title: String) {
        viewController.navigationController?.navigationBar.backgroundColor = .red
        viewController.navigationController?.navigationBar.barTintColor = .red
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        viewController.navigationItem.titleView = titleLabel
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(viewController, action: #selector(viewController.backButtonTapped), for: .touchUpInside)
        backButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
    }
    
}
extension UIViewController {
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
