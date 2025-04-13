//
//  Endpoints.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    
    var baseURL: String {
        return "https://stagingapi.mazaady.com/api/interview-tasks"
    }

    var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.path += path
        components?.queryItems = queryItems
        return components?.url
    }
}

struct UserProfileEndpoint: Endpoint {
    var path: String { "/user" }
    var method: HTTPMethod { .GET }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
}

struct ProductsEndpoint: Endpoint {
    var path: String { "/products" }
    var method: HTTPMethod { .GET }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
}

struct SearchProductsEndpoint: Endpoint {
    let name: String
    
    var path: String { "/products" }
    var method: HTTPMethod { .GET }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "name", value: name)]
    }
}

struct TagsEndpoint: Endpoint {
    var path: String { "/tags" }
    var method: HTTPMethod { .GET }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
}

struct AdvertisementsEndpoint: Endpoint {
    var path: String { "/advertisements" }
    var method: HTTPMethod { .GET }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
}
