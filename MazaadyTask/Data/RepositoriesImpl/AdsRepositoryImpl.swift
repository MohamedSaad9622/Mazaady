//
//  AdsRepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

class AdsRepositoryImpl: AdsRepository {
    func fetchAds() -> AnyPublisher<AdsResponse, any Error> {
        let endpoint = AdvertisementsEndpoint()
        return APIClient.shared.request(endpoint)
    }
}
