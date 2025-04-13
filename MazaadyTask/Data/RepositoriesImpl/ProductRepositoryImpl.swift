//
//  ProductRepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

class ProductRepositoryImpl: ProductRepository {
    
    func fetchProducts() -> AnyPublisher<[ProductModel], Error> {
        let endpoint = ProductsEndpoint()
        return APIClient.shared.request(endpoint)
    }
    
    func searchProducts(name: String) -> AnyPublisher<[ProductModel], Error> {
        let endpoint = SearchProductsEndpoint(name: name)
        return APIClient.shared.request(endpoint)
    }
}
