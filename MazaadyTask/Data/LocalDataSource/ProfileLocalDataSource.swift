//
//  ProfileLocalDataSource.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol ProfileLocalDataSourceProtocol {
    func saveProfile(_ profile: UserData)
    func fetchProfile() -> AnyPublisher<UserData, Error>
    func clearProfileCache()
}

class ProfileLocalDataSource: ProfileLocalDataSourceProtocol {
    private let cacheFileName = "profile_cache"
    private let cacheManager: CacheManagerProtocol
    
    init(cacheManager: CacheManagerProtocol = FileCacheManager()) {
        self.cacheManager = cacheManager
    }
    
    func saveProfile(_ profile: UserData) {
        cacheManager.save(profile, to: cacheFileName)
    }
    
    func fetchProfile() -> AnyPublisher<UserData, Error> {
        if let cached: UserData = cacheManager.load(cacheFileName, as: UserData.self) {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "ProfileLocalDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "No cached profile data available."]))
                .eraseToAnyPublisher()
        }
    }
    
    func clearProfileCache() {
        cacheManager.clear(fileName: cacheFileName)
    }
}

