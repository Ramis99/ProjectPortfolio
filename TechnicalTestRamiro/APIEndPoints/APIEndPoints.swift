//
//  WebServices.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 09/04/24.
//

import Foundation
struct APIEndPoints {
    private static let BASE_URL = "https://fakestoreapi.com"
    
    static let GET_ALL_CATEGORIES = "\(BASE_URL)/products/categories"
    static let GET_PRODUCTS = "\(BASE_URL)/products/category"
}
