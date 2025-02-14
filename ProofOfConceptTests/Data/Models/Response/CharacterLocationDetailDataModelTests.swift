//
//  CharacterLocationDetailDataModelTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
import Testing
@testable import ProofOfConcept

@Suite struct CharacterLocationDetailDataModelTests {
    @Suite struct Success {
        @Test func getWithValidReturnsResourceWithURL() throws {
            // Arrange
            let location = "1"

            // Act
            let resource = try CharacterLocationDetailDataModel.get(location: location)

            // Assert
            #expect(resource.url.absoluteString != nil)
        }
    }

    @Suite struct Failure {
        @Test func withInvalidURLThrowsBadUrlError() throws {
            // Arrange
            let location = "test"

            // Act & Assert
            do {
                let _ = try CharacterLocationDetailDataModel.get(location: location)
            } catch {
                #expect(((error as? NetworkError) == .badUrl))
            }
        }
    }
}
