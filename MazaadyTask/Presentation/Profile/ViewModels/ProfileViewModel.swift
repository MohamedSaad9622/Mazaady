//
//  ProfileViewModel.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

class ProfileViewModel {
    
    // Use Cases
    private let fetchProfileUseCase: FetchProfileUseCase
    private let fetchProductsUseCase: FetchProductsUseCase
    private let searchProductsUseCase: SearchProductsUseCase
    private let fetchTagsUseCase: FetchTagsUseCase
    private let fetchAdsUseCase: FetchAdsUseCase
    
    // Combine subscriptions storage
    private var cancellables = Set<AnyCancellable>()
    
    // Published properties to update the UI
    @Published var userData: UserData?
    @Published var products: [ProductModel] = []
    @Published var advertisements: [Advertisements] = []
    @Published var tags: [Tag] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(fetchProfileUseCase: FetchProfileUseCase,
         fetchProductsUseCase: FetchProductsUseCase,
         searchProductsUseCase: SearchProductsUseCase,
         fetchTagsUseCase: FetchTagsUseCase,
         fetchAdsUseCase: FetchAdsUseCase) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.fetchProductsUseCase = fetchProductsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        self.fetchAdsUseCase = fetchAdsUseCase
        self.fetchTagsUseCase = fetchTagsUseCase
        
    }

    func loadData() {
        loadProfile()
        loadProducts()
        loadTags()
        loadAdvertisements()
    }
    
    func loadProfile() {
        fetchProfileUseCase.execute()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] userData in
                self?.userData = userData
            }
            .store(in: &cancellables)
    }
    
    func loadProducts() {
        fetchProductsUseCase.execute()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
    }
    
    func searchProducts(keyword: String) {
        searchProductsUseCase.execute(keyword: keyword)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
    }
    
    func loadTags() {
        fetchTagsUseCase.execute()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] tags in
                self?.tags = tags.tags ?? []
            }
            .store(in: &cancellables)
    }
    
    func loadAdvertisements() {
        fetchAdsUseCase.execute()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] ads in
                self?.advertisements = ads.advertisements ?? []
            }
            .store(in: &cancellables)
    }
}
