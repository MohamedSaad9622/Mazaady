//
//  TagsRepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine


class TagsRepositoryImpl: TagsRepository {
    
    private let remoteService: TagsRepositoryNetworkService
    private let localDataSource: TagsLocalDataSourceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    
    init(remoteService: TagsRepositoryNetworkService = APITagsRepositoryNetworkService(),
         localDataSource: TagsLocalDataSourceProtocol = TagsLocalDataSource()) {
        self.remoteService = remoteService
        self.localDataSource = localDataSource
        
    }
    
    
    func fetchTags() -> AnyPublisher<TagResponse, Error> {
        let cachedPublisher = localDataSource.fetchTags()
        if NetworkMonitor.shared.isConnected {
            return remoteService.fetchTags()
                .handleEvents(receiveOutput: { [weak self] tags in
                    self?.localDataSource.saveTags(tags)
                })
                .eraseToAnyPublisher()
        } else {
            return cachedPublisher
        }
    }

}
