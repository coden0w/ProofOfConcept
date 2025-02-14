//
//  MockApiClient.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
@testable import ProofOfConcept

actor MockApiClient: APIClient {
    func request<T>(_ resource: Resource<T>) async throws -> T where T : Decodable, T : Encodable, T : Sendable {
        guard let response: T = mockCharacters as? T else {
            fatalError()
        }
        return response
    }
}
