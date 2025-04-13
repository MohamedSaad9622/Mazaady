//
//  DependencyContainer.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()

    private init() {}

    func makeProductUseCases() -> ProfileViewModel {
        let profileRepository = ProfileRepositoryImpl()
        let productRepository = ProductRepositoryImpl()
        let tagsRepository = TagsRepositoryImpl()
        let adsRepository = AdsRepositoryImpl()
        
        return ProfileViewModel(
            fetchProfileUseCase: DefaultFetchProfileUseCase(repository: profileRepository),
            fetchProductsUseCase: DefaultFetchProductsUseCase(repository: productRepository),
            searchProductsUseCase: DefaultSearchProductsUseCase(repository: productRepository),
            fetchTagsUseCase: DefaultFetchTagsUseCase(repository: tagsRepository),
            fetchAdsUseCase: DefaultFetchAdsUseCase(repository: adsRepository)
        )
    }

}
