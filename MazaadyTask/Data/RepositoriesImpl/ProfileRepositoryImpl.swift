//
//  RepositoryImpl.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

class ProfileRepositoryImpl: ProfileRepository {
    
    func fetchUserProfile() -> AnyPublisher<UserData, Error> {
        let endpoint = UserProfileEndpoint()
        return APIClient.shared.request(endpoint)
    }
    
}
