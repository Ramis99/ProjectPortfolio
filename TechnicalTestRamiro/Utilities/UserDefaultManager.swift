//
//  UserDefaultManager.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 10/04/24.
//

import Foundation

struct UserDefaultsKeys {
    static let categories = "Categories"
    static let selectedCategoryProducts = "SelectedCategoryProducts"
    
}

class UserDefaultsManager {
    public static func saveCategories(_ categories: [CategoryModel]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(categories) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.categories)
        }
    }
    public static func loadCategories() -> [CategoryModel] {
        if let savedCategoriesData = UserDefaults.standard.data(forKey: UserDefaultsKeys.categories) {
            let decoder = JSONDecoder()
            if let loadedCategories = try? decoder.decode([CategoryModel].self, from: savedCategoriesData) {
                return loadedCategories
            }
        }
        return []
    }
    
    public static func saveProducts(products: [ProductsModel], forCategory category: String) {
        let encodedData = try? JSONEncoder().encode(products)
        UserDefaults.standard.set(encodedData, forKey: category)
    }
    public static func loadProducts(forCategory category: String) -> [ProductsModel]? {
        if let savedData = UserDefaults.standard.data(forKey: category),
           let products = try? JSONDecoder().decode([ProductsModel].self, from: savedData) {
            return products
        }
        return nil
    }
}
