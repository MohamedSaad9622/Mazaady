//
//  FetchProfileUseCase.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

protocol FetchProfileUseCase {
    func execute() -> AnyPublisher<UserData, Error>
}

class DefaultFetchProfileUseCase: FetchProfileUseCase {
    private let repository: ProfileRepository
    
    init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<UserData, Error> {
        repository.fetchUserProfile()
    }
}
