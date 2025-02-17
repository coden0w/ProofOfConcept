//
//  APIClientTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
import Testing
@testable import ProofOfConcept

@Suite struct APIClientTests {
    @Suite struct Success {
        @Test func requestWithValidResponseReturnsDecodedData() async throws {
            // Arrange
            let expectedData = TestModel(id: 1, name: "Test")
            let mockData = try JSONEncoder().encode(expectedData)
            let mockURL = URL(string: "https://rickandmortyapi.com")!
            let mockResource = Resource<TestModel>(url: mockURL)
            
            let mockSession = MockURLSession(data: mockData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
            let client = DefaultAPIClient(session: mockSession)
            
            // Act
            let result = try await client.request(mockResource)
            
            // Assert
            #expect(result.id == expectedData.id)
            #expect(result.name == expectedData.name)
        }
    }

    @Suite struct Failure {
        @Test func requestWithDecodingErrorThrowsDecodingError() async {
            // Arrange
            let invalidData = Data("invalid".utf8)
            let mockURL = URL(string: "https://rickandmortyapi.com")!
            let mockResource = Resource<TestModel>(url: mockURL)
            
            let mockSession = MockURLSession(data: invalidData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
            let client = DefaultAPIClient(session: mockSession)
            
            // Act & Assert
            do {
                _ = try await client.request(mockResource)
                Issue.record("Expected decodingError, but it succeeded")
            } catch NetworkError.decodingError {
                // Success
            } catch {
                Issue.record("Expected decodingError, but got \(error)")
            }
        }
    }
}
