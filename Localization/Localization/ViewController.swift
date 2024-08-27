//
//  ViewController.swift
//  Localization
//
//  Created by abcd on 23/08/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func languageSegment(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{ //English
            firstNameLabel.text = "FirstNameKey".localizableString(local: "en")
            lastNameLabel.text = "LastNameKey".localizableString(local: "en")
        }else{
            firstNameLabel.text = "FirstNameKey".localizableString(local: "es")
            lastNameLabel.text = "LastNameKey".localizableString(local: "es")
        }
        
    }
}
extension String{
    func localizableString(local: String)-> String{
        let path = Bundle.main.path(forResource: local, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self , tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

