//
//  ProductRepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

class ProductRepositoryImpl: ProductRepository {
    
    private let remoteService: ProductRepositoryNetworkService
    private let localDataSource: ProductLocalDataSourceProtocol
    private var cancellables = Set<AnyCancellable>()

    
    init(remoteService: ProductRepositoryNetworkService = APIProductRepositoryNetworkService(),
         localDataSource: ProductLocalDataSourceProtocol = ProductLocalDataSource()) {
        self.remoteService = remoteService
        self.localDataSource = localDataSource

    }
    
    func fetchProducts() -> AnyPublisher<[ProductModel], Error> {
        let cachedPublisher = localDataSource.fetchProducts()
        if NetworkMonitor.shared.isConnected {
            return remoteService.fetchProducts()
                .handleEvents(receiveOutput: { [weak self] products in
                    self?.localDataSource.saveProducts(products)
                })
                .prepend(cachedPublisher) // Show cached data immediately, then live data.
                .eraseToAnyPublisher()
        } else {
            return cachedPublisher
        }
    }
    
    func searchProducts(name: String) -> AnyPublisher<[ProductModel], Error> {
        let searchQuery = name.lowercased()
        if NetworkMonitor.shared.isConnected {
            return remoteService.searchProducts(name: name)
                .eraseToAnyPublisher()
        } else {
            // When offline, filter the cached products.
            return localDataSource.fetchProducts()
                .map { products in
                    products.filter { $0.name?.lowercased().contains(searchQuery) ?? false }
                }
                .eraseToAnyPublisher()
        }
    }

    
}
