//
//  FetchData.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 09/04/24.
//

import Alamofire

class NetworkRequest {
    static let shared = NetworkRequest()
    
    
    func fetchCategories(completion: @escaping ([CategoryModel]?, Error?) -> Void) {
        AF.request(APIEndPoints.GET_ALL_CATEGORIES)
            .responseJSON { response in
                switch (response.result) {
                case .success(let categories):
                    if let array  = categories as? [String] {
                        let categoryModels = array.map { CategoryModel(name: $0, products: []) }
                        completion(categoryModels, nil)
                    } else {
                        let error = NSError(domain: "Error de formato", code: 0, userInfo: [NSLocalizedDescriptionKey: "La respuesta del servidor no es válida"])
                        completion(nil, error)
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    func fetchProducts(for category: String, completion: @escaping([ProductsModel]?, Error?) -> Void) {
        let url = "\(APIEndPoints.GET_PRODUCTS)/\(category)"
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let jsonArray = value as? [[String: Any]] else {
                        completion(nil, NSError(domain: "ParsingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error al parsear la respuesta JSON"]))
                        return
                    }
                    let products: [ProductsModel] = jsonArray.compactMap { jsonObject in
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                            let product = try JSONDecoder().decode(ProductsModel.self, from: jsonData)
                            return product
                        } catch {
                            print("Error al decodificar el producto:", error)
                            return nil
                        }
                    }
                    completion(products, nil)
                    
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
