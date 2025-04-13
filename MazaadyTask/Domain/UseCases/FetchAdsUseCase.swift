//
//  FetchAdsUseCase.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine


protocol FetchAdsUseCase {
    func execute() -> AnyPublisher<AdsResponse, Error>
}

class DefaultFetchAdsUseCase: FetchAdsUseCase {
    let repository: AdsRepository
    
    init(repository: AdsRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<AdsResponse, Error> {
        return repository.fetchAds()
    }
}
