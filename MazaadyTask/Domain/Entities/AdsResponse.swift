//
//  AdsResponse.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//


struct AdsResponse: Codable {
    let advertisements: [Advertisements]?
}

struct Advertisements: Codable, Hashable, Sendable {
    let id: Int?
    let image: String?
}
