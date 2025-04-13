//
//  ProductModel.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation


struct ProductModel: Codable, Hashable, Sendable {
    let id: Int?
    let name: String?
    let image: String?
    let price: Double?
    let currency: String?
    let offer: Double?
    let endDate: Double?
    
    
    private let dataFetchDate: Date = Date()
    
    /// Computed property that calculates an absolute target date once when data is received.
    var targetDate: Date? {
        guard let seconds = endDate else { return nil }
        return dataFetchDate.addingTimeInterval(seconds)
    }

    enum CodingKeys: String, CodingKey {
        case id, name, image, price, currency, offer
        case endDate = "end_date"
    }
}
