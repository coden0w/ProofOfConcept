//
//  ApiRespositoryTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
import Testing
@testable import ProofOfConcept

@Suite struct ApiRespositoryTests {
    @Test func getAllCharacters() async throws {
        // Arrange
        let expectedData = mockCharactersData
        let mockData = try JSONEncoder().encode(expectedData)
        let mockURL = URL(string: "rickandmortyapi.com")!
        let mockSession = MockURLSession(data: mockData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
        let client = DefaultAPIClient(session: mockSession)
        let mockRepository = ApiRepositoryImpl(apiClient: client)

        Task {
            // Act
            let result = try await mockRepository.getAllCharacters(requestModel: CharactersRequestDomainModel(page: 1))
            
            // Assert
            #expect(result.characters.first?.id == expectedData.characters?.first?.id)
        }
    }
    
    @Test func getCharacterLocation() async throws {
        // Arrange
        let expectedData = mockCharactersData
        let mockData = try JSONEncoder().encode(expectedData)
        let mockURL = URL(string: "rickandmortyapi.com")!
        let mockSession = MockURLSession(data: mockData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
        let client = DefaultAPIClient(session: mockSession)
        let mockRepository = ApiRepositoryImpl(apiClient: client)

        Task {
            // Act
            let result = try await mockRepository.getCharacterLocation(requestModel: CharacterLocationDetailRequestDomainModel(location: "1"))
            
            // Assert
            #expect(result.id == expectedData.characters?.first?.id)
        }
    }
    
    @Test func getCharacterEpisode() async throws {
        // Arrange
        let expectedData = mockCharactersData
        let mockData = try JSONEncoder().encode(expectedData)
        let mockURL = URL(string: "rickandmortyapi.com")!
        let mockSession = MockURLSession(data: mockData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
        let client = DefaultAPIClient(session: mockSession)
        let mockRepository = ApiRepositoryImpl(apiClient: client)

        Task {
            // Act
            let result = try await mockRepository.getCharacterEpisode(requestModel: CharacterEpisodeDetailRequestDomainModel(episode: "1"))
            
            // Assert
            #expect(result.id == expectedData.characters?.first?.id)
        }
    }
}
