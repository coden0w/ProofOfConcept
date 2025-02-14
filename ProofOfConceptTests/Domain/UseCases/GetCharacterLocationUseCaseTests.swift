//
//  GetCharacterLocationUseCaseTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Testing
@testable import ProofOfConcept

@Suite struct GetCharacterLocationUseCaseTests {
    @Test func handle() async throws {
        Task {
            let mockRepository = MockApiRepository()

            // Arrange
            let mockCharacter = mockCharacterLocationDetail

            // Act
            let mockUseCase: UseCaseProtocol = GetCharacterLocationUseCase(repository: mockRepository)
            let response: CharacterLocationDetailDomainModel = try await mockUseCase.execute(CharacterLocationDetailRequestDomainModel(location: ""))

            // Assert
            #expect(await response.id == mockCharacter.id)
        }
    }
}
