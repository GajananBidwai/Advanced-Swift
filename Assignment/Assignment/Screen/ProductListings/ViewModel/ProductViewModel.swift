//
//  ProductViewModel.swift
//  Assignment
//
//  Created by abcd on 26/08/24.
//

import Foundation
final class ProductViewModel{
    var product: Product?
    var eventHandler: ((_ event: Event)->Void)?
    func fetchProduct(){
        self.eventHandler?(.Loading)
        ApiManager.shared.fetchProduct { Response in
            self.eventHandler?(.StopLoading)
            switch Response{
            case .success(let product):
                self.product = product
                self.eventHandler?(.DataLoaded)
            case .failure(let error):
                self.eventHandler?(.Error(error))
            }
        }
    }
}
extension ProductViewModel{
    enum Event{
        case Loading
        case StopLoading
        case DataLoaded
        case Error(Error?)
    }
}
