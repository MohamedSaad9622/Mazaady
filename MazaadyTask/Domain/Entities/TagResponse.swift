//
//  TagResponse.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//


struct TagResponse: Codable {
    let tags: [Tag]?
}

struct Tag: Codable, Hashable, Sendable {
    let id: Int?
    let name: String?
}
