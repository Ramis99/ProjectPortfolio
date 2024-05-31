//
//  ProductsModel.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 09/04/24.
//

import Foundation

struct CategoryModel: Codable {
    let name: String
    let products: [ProductsModel]
}

struct ProductsModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: RatingModel
}

struct RatingModel: Codable {
    let rate: Double
    let count: Int
}
