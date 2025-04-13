//
//  SearchProductsUseCase.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

protocol SearchProductsUseCase {
    func execute(keyword: String) -> AnyPublisher<[ProductModel], Error>
}

class DefaultSearchProductsUseCase: SearchProductsUseCase {
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func execute(keyword: String) -> AnyPublisher<[ProductModel], Error> {
        repository.searchProducts(name: keyword)
    }
}
