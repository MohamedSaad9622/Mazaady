//
//  ProductLocalDataSource.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol ProductLocalDataSourceProtocol {
    func saveProducts(_ products: [ProductModel])
    func fetchProducts() -> AnyPublisher<[ProductModel], Error>
    func clearProductsCache()
}

class ProductLocalDataSource: ProductLocalDataSourceProtocol {
    private let cacheFileName = "products_cache"
    private let cacheManager: CacheManagerProtocol
    
    init(cacheManager: CacheManagerProtocol = FileCacheManager()) {
        self.cacheManager = cacheManager
    }
    
    func saveProducts(_ products: [ProductModel]) {
        cacheManager.save(products, to: cacheFileName)
    }
    
    func fetchProducts() -> AnyPublisher<[ProductModel], Error> {
        if let cached: [ProductModel] = cacheManager.load(cacheFileName, as: [ProductModel].self) {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "ProductLocalDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "No cached products available."]))
                .eraseToAnyPublisher()
        }
    }
    
    func clearProductsCache() {
        cacheManager.clear(fileName: cacheFileName)
    }
}
