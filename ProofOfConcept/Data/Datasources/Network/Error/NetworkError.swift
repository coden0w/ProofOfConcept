//
//  NetworkError.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}
