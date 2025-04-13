//
//  RepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

class ProfileRepositoryImpl: ProfileRepository {
    
    private let remoteService: ProfileRepositoryNetworkService
    private let localDataSource: ProfileLocalDataSourceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(remoteService: ProfileRepositoryNetworkService = APIProfileRepositoryNetworkService(),
         localDataSource: ProfileLocalDataSourceProtocol = ProfileLocalDataSource()) {
        self.remoteService = remoteService
        self.localDataSource = localDataSource

    }
    
    func fetchUserProfile() -> AnyPublisher<UserData, any Error> {
        let cachedPublisher = localDataSource.fetchProfile()
        if NetworkMonitor.shared.isConnected {
            return remoteService.fetchUserProfile()
                .handleEvents(receiveOutput: { [weak self] profile in
                    self?.localDataSource.saveProfile(profile)
                })
                .eraseToAnyPublisher()
        } else {
            return cachedPublisher
        }
    }
}
