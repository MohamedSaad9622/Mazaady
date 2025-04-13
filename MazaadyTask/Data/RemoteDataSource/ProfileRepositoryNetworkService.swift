//
//  ProfileRepositoryNetworkService.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import Combine

protocol ProfileRepositoryNetworkService {
    func fetchUserProfile() -> AnyPublisher<UserData, Error>
}

class APIProfileRepositoryNetworkService: ProfileRepositoryNetworkService {
    func fetchUserProfile() -> AnyPublisher<UserData, Error> {
        let endpoint = UserProfileEndpoint()
        return APIClient.shared.request(endpoint)
    }
}
