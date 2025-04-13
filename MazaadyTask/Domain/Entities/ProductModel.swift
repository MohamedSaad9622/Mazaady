//
//  ProductModel.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//


struct ProductModel: Codable, Hashable, Sendable {
    let id: Int?
    let name: String?
    let image: String?
    let price: Double?
    let currency: String?
    let offer: Double?
    let endDate: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, image, price, currency, offer
        case endDate = "end_date"
    }
}

extension ProductModel {
    var countdownComponents: (days: Int, hours: Int, minutes: Int)? {
        guard let endDate = endDate else { return nil }
        let totalSeconds = Int(endDate)

        let days = totalSeconds / 86400
        let hours = (totalSeconds % 86400) / 3600
        let minutes = (totalSeconds % 3600) / 60

        return (days, hours, minutes)
    }
}
