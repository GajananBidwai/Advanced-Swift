//
//  ApiManager.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import Foundation
enum ProductError: Error{
    case invalidData
    case invalidResponse
    case invalidDecoding
    case network(Error?)
}

final class ApiManager{
    static let shared = ApiManager()
    private init() {}
    typealias Handler = (Result<Product, ProductError>)-> Void
    func fetchProduct(completion: @escaping Handler){
        guard let url = URL(string: Constant.Api.productUrl) else{
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else{
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let product = try JSONDecoder().decode(Product.self, from: data)
                completion(.success(product))
                
            }catch let error{
                completion(.failure(.network(error)))
            }
            
        }.resume()
        
    }
}
