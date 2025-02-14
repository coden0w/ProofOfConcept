//
//  URL+Characters.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation

extension URL {
    private enum Constants {
        static let scheme = "https"
        static let host = "rickandmortyapi.com"
    }

    static func fetch(path: String? = nil, queryParams: [[String: String]]? = nil) throws -> URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        
        if let path {
            components.path = path
        }

        if let queryParams, !queryParams.isEmpty {
            components.queryItems = queryParams.flatMap {
                $0.map {
                    URLQueryItem(name: $0.key, value: $0.value)
                }
            }
        }

        guard let url = components.url else {
            throw NetworkError.badUrl
        }

        return url
    }
}
