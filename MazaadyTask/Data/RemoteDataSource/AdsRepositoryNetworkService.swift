//
//  AdsRepositoryNetworkService.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol AdsRepositoryNetworkService {
    func fetchAds() -> AnyPublisher<AdsResponse, any Error>
}

class APIAdsRepositoryNetworkService: AdsRepositoryNetworkService {
    func fetchAds() -> AnyPublisher<AdsResponse, any Error> {
        let endpoint = AdvertisementsEndpoint()
        return APIClient.shared.request(endpoint)
    }
}
