//
//  LocalStorage.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation

class LocalStorage {
    static let shared = LocalStorage()
    
    func save<T: Encodable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(object) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func retrieve<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        let object = try? decoder.decode(type, from: data)
        return object
    }
}
