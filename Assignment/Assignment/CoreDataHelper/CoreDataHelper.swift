//
//  CoreDataHelper.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import CoreData
import UIKit

final class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private init() {}
    
    func saveProductDataToCoreData(id: Int){
        let products = NSEntityDescription.insertNewObject(forEntityName: "ProductEntity", into: context!) as! ProductEntity
        
            products.productId = "\(id)"
//        products.description1 = productEntity["description1"]
//        products.name = productEntity["name"]
//        products.price = productEntity["price"]
//        products.producer = productEntity["producer"]
//        products.rating = productEntity["rating"]
        
        do{
            try context?.save()
        }catch let error{
            print(error)
        }
    }
    
    func deleteProduct(id: Int) {
        var productArray = [ProductEntity]()
        let predicate = NSPredicate(format: "productId == %@", "\(id)")
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductEntity")
        fetchRequest.predicate = predicate
        do{
            productArray = try context?.fetch(fetchRequest) as? [ProductEntity] ?? []
            if let product = productArray.first {
                context?.delete(product)
                try context?.save()
            }
        }catch let error{
            print(error)
        }
    }
    func checkIfIDAlreadyExists(productId: String)-> Bool{
        var productArray = [ProductEntity]()
        let predicate = NSPredicate(format: "productId == %@", productId)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductEntity")
        fetchRequest.predicate = predicate
        
        do{
            productArray = try context?.fetch(fetchRequest) as? [ProductEntity] ?? []
        }catch let error{
            print(error)
        }
        return !productArray.isEmpty
    }
}
