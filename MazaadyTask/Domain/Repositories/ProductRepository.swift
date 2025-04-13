//
//  ProductRepository.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

protocol ProductRepository {
    func fetchProducts() -> AnyPublisher<[ProductModel], Error>
    func searchProducts(name: String) -> AnyPublisher<[ProductModel], Error>
}
