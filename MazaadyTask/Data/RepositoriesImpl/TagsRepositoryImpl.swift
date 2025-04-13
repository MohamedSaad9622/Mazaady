//
//  TagsRepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine


class TagsRepositoryImpl: TagsRepository {
    func fetchTags() -> AnyPublisher<TagResponse, Error> {
        let endPoint = TagsEndpoint()
        return APIClient.shared.request(endPoint)
    }
}
