//
//  FileCacheManager.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation

final class FileCacheManager: CacheManagerProtocol {
    private let fileManager = FileManager.default

    private func fileURL(for fileName: String) -> URL {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        return cachesDirectory.appendingPathComponent("\(fileName).json")
    }

    func save<T: Codable>(_ object: T, to fileName: String) {
        let url = fileURL(for: fileName)
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: url)
            print("✅ Data cached at \(url.path)")
        } catch {
            print("🛑 Error saving cache: \(error)")
        }
    }

    func load<T: Codable>(_ fileName: String, as type: T.Type) -> T? {
        let url = fileURL(for: fileName)
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("⚠️ Error loading cache: \(error)")
            return nil
        }
    }

    func clear(fileName: String) {
        let url = fileURL(for: fileName)
        try? fileManager.removeItem(at: url)
    }
}
