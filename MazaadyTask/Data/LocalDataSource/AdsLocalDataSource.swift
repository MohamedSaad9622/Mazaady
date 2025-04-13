//
//  AdsLocalDataSource.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol AdsLocalDataSourceProtocol {
    func fetchAds() -> AnyPublisher<AdsResponse, Error>
    func saveAds(_ ads: AdsResponse)
    func clearAdsCache()
}

class AdsLocalDataSource: AdsLocalDataSourceProtocol {
    private let cacheFileName = "ads_cache"
    private let cacheManager: CacheManagerProtocol
    
    init(cacheManager: CacheManagerProtocol = FileCacheManager()) {
        self.cacheManager = cacheManager
    }
    
    func saveAds(_ ads: AdsResponse) {
        cacheManager.save(ads, to: cacheFileName)
    }
    
    func fetchAds() -> AnyPublisher<AdsResponse, Error> {
        if let cached: AdsResponse = cacheManager.load(cacheFileName, as: AdsResponse.self) {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "AdsLocalDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "No cached Ads data available."]))
                .eraseToAnyPublisher()
        }
    }
    
    func clearAdsCache() {
        cacheManager.clear(fileName: cacheFileName)
    }
}

