//
//  ProductsViewModel.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 09/04/24.
//

import Foundation

class ProductsViewModel {
    var categories: [CategoryModel] = []
    var categorySelected: String?
    var products: [ProductsModel] = []
    
    func fetchCategories(completion: @escaping (Error?) -> Void) {
        NetworkRequest.shared.fetchCategories { [weak self] (categories, error) in
            guard let self = self else { return }
            if let categories = categories {
                self.categories = categories
                completion(nil)
            } else if let error = error {
                completion(error)
            }
        }
    }
    
    func fetchProducts(for category: String, completion: @escaping (Error?) -> Void) {
        NetworkRequest.shared.fetchProducts(for: category) { [weak self] (products, error) in
            guard let self = self else { return }
            if let products = products {
                self.products = products
                completion(nil)
            } else if let error = error {
                completion(error)
                print(String(describing: error))
            }
        }
    }
}
