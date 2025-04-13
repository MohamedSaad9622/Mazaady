//
//  TagsRepositoryNetworkService.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol TagsRepositoryNetworkService {
    func fetchTags() -> AnyPublisher<TagResponse, Error>
}

class APITagsRepositoryNetworkService: TagsRepositoryNetworkService {
    func fetchTags() -> AnyPublisher<TagResponse, Error> {
        let endPoint = TagsEndpoint()
        return APIClient.shared.request(endPoint)
    }
}
