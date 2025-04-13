//
//  AdsRepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

class AdsRepositoryImpl: AdsRepository {
    
    private let remoteService: AdsRepositoryNetworkService
    private let localDataSource: AdsLocalDataSourceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(remoteService: AdsRepositoryNetworkService = APIAdsRepositoryNetworkService(),
         localDataSource: AdsLocalDataSourceProtocol = AdsLocalDataSource()) {
        self.remoteService = remoteService
        self.localDataSource = localDataSource
        
    }
    
    
    func fetchAds() -> AnyPublisher<AdsResponse, any Error> {
        let cachedPublisher = localDataSource.fetchAds()
        if NetworkMonitor.shared.isConnected {
            return remoteService.fetchAds()
                .handleEvents(receiveOutput: { [weak self] ads in
                    self?.localDataSource.saveAds(ads)
                })
                .prepend(cachedPublisher) // Show cached data immediately, then live data.
                .eraseToAnyPublisher()
        } else {
            return cachedPublisher
        }
    }

}
