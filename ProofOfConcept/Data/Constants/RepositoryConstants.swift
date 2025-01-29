//
//  RepositoryConstants.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

struct RepositoryConstants {
    enum PathUrl: String {
        case api = "api"
        case none = ""
    }

    enum EndpointUrl: String {
        case character = "character"
        case location = "location"
        case episode = "episode"
        case none = ""
    }
    
    static func buildURL(baseURL: String,
                         paths: [PathUrl],
                         endpoint: EndpointUrl,
                         queryParams: [String: String] = [:]) throws -> URL {
        
        var urlString = baseURL // https://rickandmortyapi.com
        
        let fullPath = paths.filter({ $0 != .none }).map({ $0.rawValue }).joined(separator: "/")
        if !fullPath.isEmpty {
            urlString = String(format: "%@/%@", urlString, fullPath)
        }
        
        if endpoint != .none {
            urlString = String(format: "%@/%@", urlString, endpoint.rawValue)
        }
        
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NSError(domain: "Bad Url Error", code: 3, userInfo: nil)
        }
        
        if !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw NSError(domain: "Bad Url Error", code: 3, userInfo: nil)
        }
        
        return url
    }
}
