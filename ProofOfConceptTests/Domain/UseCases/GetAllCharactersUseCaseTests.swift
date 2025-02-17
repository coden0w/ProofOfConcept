//
//  GetAllCharactersUseCaseTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Testing
@testable import ProofOfConcept

@Suite struct GetAllCharactersUseCaseTests {
    @Test func handle() async throws {
        Task {
            let mockRepository = MockApiRepository()

            // Arrange
            let mockCharacter = mockCharacters

            // Act
            let mockUseCase: UseCaseProtocol = GetAllCharactersUseCase(repository: mockRepository)
            let response: CharactersDomainModel = try await mockUseCase.execute(CharactersRequestDomainModel(page: 1))

            // Assert
            #expect(response.characters.first?.id == mockCharacter.characters.first?.id)
        }
    }
}
