//
//  Product.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import Foundation
struct Product: Decodable{
    var status: Int
    var data: [Data]
}
struct Data: Decodable{
    var id: Int
    var product_category_id: Int
    var name: String
    var producer: String
    var description: String
    var cost: Int
    var rating: Int
    var product_images: String
    var isWishlisted: Bool {
        CoreDataHelper.shared.checkIfIDAlreadyExists(productId: "\(id)")
    }
}
