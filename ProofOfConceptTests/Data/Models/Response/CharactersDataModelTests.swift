//
//  CharactersDataModelTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
import Testing
@testable import ProofOfConcept

@Suite struct CharactersDataModelTests {
    @Suite struct Success {
        @Test func getWithValidReturnsResourceWithURL() throws {
            // Arrange
            let page = "1"

            // Act
            let resource = try CharactersDataModel.get(page: page)

            // Assert
            #expect(resource.url.absoluteString != nil)
        }
    }

    @Suite struct Failure {
        @Test func withInvalidURLThrowsBadUrlError() throws {
            // Arrange
            let page = "test"

            // Act & Assert
            do {
                let _ = try CharactersDataModel.get(page: page)
            } catch {
                #expect(((error as? NetworkError) == .badUrl))
            }
        }
    }
}
