//
//  TagsLocalDataSource.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol TagsLocalDataSourceProtocol {
    func saveTags(_ tags: TagResponse)
    func fetchTags() -> AnyPublisher<TagResponse, Error>
    func clearTagsCache()
}

class TagsLocalDataSource: TagsLocalDataSourceProtocol {
    private let cacheFileName = "tags_cache"
    private let cacheManager: CacheManagerProtocol
    
    init(cacheManager: CacheManagerProtocol = FileCacheManager()) {
        self.cacheManager = cacheManager
    }
    
    func saveTags(_ tags: TagResponse) {
        cacheManager.save(tags, to: cacheFileName)
    }
    
    func fetchTags() -> AnyPublisher<TagResponse, Error> {
        if let cached: TagResponse = cacheManager.load(cacheFileName, as: TagResponse.self) {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "TagsLocalDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "No cached Tags data available."]))
                .eraseToAnyPublisher()
        }
    }
    
    func clearTagsCache() {
        cacheManager.clear(fileName: cacheFileName)
    }
}

