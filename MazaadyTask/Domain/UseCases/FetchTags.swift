//
//  FetchTags.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine


protocol FetchTagsUseCase {
    func execute() -> AnyPublisher<TagResponse, Error>
}

class DefaultFetchTagsUseCase: FetchTagsUseCase {
    
   private let repository: TagsRepository
    
    init(repository: TagsRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<TagResponse, Error> {
        repository.fetchTags()
    }
}
