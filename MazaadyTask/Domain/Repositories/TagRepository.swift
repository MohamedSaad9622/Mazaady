//
//  TagRepository.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

protocol TagsRepository {
    func fetchTags() -> AnyPublisher<TagResponse, Error>
}
