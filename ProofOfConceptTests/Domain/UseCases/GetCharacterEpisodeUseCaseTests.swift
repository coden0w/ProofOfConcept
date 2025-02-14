//
//  GetCharacterEpisodeUseCaseTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Testing
@testable import ProofOfConcept

@Suite struct GetCharacterEpisodeUseCaseTests {
    @Test func handle() async throws {
        Task {
            let mockRepository = MockApiRepository()

            // Arrange
            let mockCharacter = mockCharacterEpisodeDetail

            // Act
            let mockUseCase: UseCaseProtocol = GetCharacterEpisodeUseCase(repository: mockRepository)
            let response: CharacterEpisodeDetailDomainModel = try await mockUseCase.execute(CharacterEpisodeDetailRequestDomainModel(episode: "1"))

            // Assert
            #expect(response.id == mockCharacter.id)
        }
    }
}
