//
//  FetchProductsUseCase.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

protocol FetchProductsUseCase {
    func execute() -> AnyPublisher<[ProductModel], Error>
}

class DefaultFetchProductsUseCase: FetchProductsUseCase {
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[ProductModel], Error> {
        repository.fetchProducts()
    }
}
