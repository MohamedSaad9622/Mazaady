//
//  ProductRepositoryNetworkService.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol ProductRepositoryNetworkService {
    func fetchProducts() -> AnyPublisher<[ProductModel], Error>
    func searchProducts(name: String) -> AnyPublisher<[ProductModel], Error>
}

class APIProductRepositoryNetworkService: ProductRepositoryNetworkService {
    func fetchProducts() -> AnyPublisher<[ProductModel], Error> {
        let endpoint = ProductsEndpoint()
        return APIClient.shared.request(endpoint)
    }

    func searchProducts(name: String) -> AnyPublisher<[ProductModel], Error> {
        let endpoint = SearchProductsEndpoint(name: name)
        return APIClient.shared.request(endpoint)
    }
}
