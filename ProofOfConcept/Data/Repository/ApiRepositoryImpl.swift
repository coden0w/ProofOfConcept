//
//  ApiRepositoryImpl.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine


public actor ApiRepositoryImpl: ApiRepository {
    
    private static var instance: ApiRepositoryImpl?
    public var baseURL: String
    
    public static func shared(baseURL: String) -> ApiRepository {
        if let instance = ApiRepositoryImpl.instance {
            return instance
        } else {
            let repository = ApiRepositoryImpl(baseURL: baseURL)
            ApiRepositoryImpl.instance = repository
            return repository
        }
    }
    
    internal init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    public func getAllCharacters() async throws -> CharactersDomainModel {
        do {
            let url = try RepositoryConstants.buildURL(baseURL: baseURL,
                                                   paths: [.api],
                                                   endpoint: .character)
            let request = request(url: url, method: .get, encoding: .json)
            let response = try await response(request: request)
            try checkResponse(response)
            let domainModel = try CharactersDataModel(data: response.0).parseToDomainModel()
            return domainModel
        } catch {
            throw error
        }
    }
}

// MARK: - Extension

extension ApiRepositoryImpl {
    
    enum RequestType: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum EncodingType: String {
        static let key = "Content-Type"
        
        case json = "application/json"
        case form = "application/x-www-form-urlencoded"
    }
    
    func request(url: URL, method: RequestType, encoding: EncodingType) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(encoding.rawValue, forHTTPHeaderField: EncodingType.key)
        return request
    }
    
    func response(request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            let result = try await URLSession.shared.data(for: request)
            try checkResponse(result)
            return result
        } catch {
            throw error
        }
    }
    
    func checkResponse(_ result: (Data, URLResponse)) throws {
        let (_, response) = result
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                return
            case 400...403:
                throw NSError(domain: "Unauthorized Error", code: 0)
            case 500:
                throw NSError(domain: "Internal Server Error", code: 1)
            default:
                throw NSError(domain: "Unknown Error", code: 2)
            }
        }
    }
}
