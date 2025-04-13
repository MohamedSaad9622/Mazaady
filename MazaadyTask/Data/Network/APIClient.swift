//
//  APIClient.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import Foundation
import Combine

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int, message: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "The response is not valid."
        case .noData:
            return "No data received."
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .serverError(let code, let message):
            return "Server Error (\(code)): \(message)"
        }
    }
}

class APIClient {
    static let shared = APIClient()

    func request<T: Decodable>(_ endpoint: Endpoint, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                guard (200...299).contains(response.statusCode) else {
                    let errorMessage = String(data: output.data, encoding: .utf8) ?? "No message"
                    print("responsestatus \(response.statusCode)")
                    throw NetworkError.serverError(statusCode: response.statusCode, message: errorMessage)
                }

                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                }
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
