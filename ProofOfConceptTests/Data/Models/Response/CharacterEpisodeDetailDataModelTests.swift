//
//  CharacterEpisodeDetailDataModelTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
import Testing
@testable import ProofOfConcept

@Suite struct CharacterEpisodeDetailDataModelTests {
    @Suite struct Success {
        @Test func getWithValidReturnsResourceWithURL() throws {
            // Arrange
            let episode = "1"

            // Act
            let resource = try CharacterEpisodeDetailDataModel.get(episode: episode)

            // Assert
            #expect(resource.url.absoluteString != nil)
        }
    }

    @Suite struct Failure {
        @Test func withInvalidURLThrowsBadUrlError() throws {
            // Arrange
            let episode = "test"

            // Act & Assert
            do {
                let _ = try CharacterEpisodeDetailDataModel.get(episode: episode)
            } catch {
                #expect(((error as? NetworkError) == .badUrl))
            }
        }
    }
}
