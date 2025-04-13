//
//  CacheManagerProtocol.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation

protocol CacheManagerProtocol {
    func save<T: Codable>(_ object: T, to fileName: String)
    func load<T: Codable>(_ fileName: String, as type: T.Type) -> T?
    func clear(fileName: String)
}
