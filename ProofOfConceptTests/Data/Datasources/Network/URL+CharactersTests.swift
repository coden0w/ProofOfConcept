//
//  URL+CharactersTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
import Testing
@testable import ProofOfConcept

@Suite struct URLTests {
    @Suite struct Success {
        @Test func fetchWithValidResponseReturnsDecodedData() async throws {
            // Arrange & Act
            let result = try URL.fetch(path: "/api/", queryParams: [["page": "1"]])
            
            // Assert
            #expect(result?.scheme == "https")
            #expect(result?.host == "rickandmortyapi.com")
            #expect(result?.path == "/api")
            #expect(result?.query != nil)
            #expect(result?.absoluteURL.description == "https://rickandmortyapi.com/api/?page=1")
        }
    }
}
