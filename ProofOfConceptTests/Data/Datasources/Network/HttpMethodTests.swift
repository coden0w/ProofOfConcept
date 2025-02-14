//
//  HttpMethodTests.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
import Testing
@testable import ProofOfConcept

@Suite struct HttpMethodTests {
    @Suite struct Success {
        @Test func validateMethods() async throws {
            // Arrange & Act
            let get = HttpMethod.get
            let post = HttpMethod.post
            
            // Assert
            #expect(get.name == "GET")
            #expect(post(nil).name == "POST")
        }
    }
}
