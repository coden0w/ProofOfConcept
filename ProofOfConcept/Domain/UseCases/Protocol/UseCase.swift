//
//  UseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

// MARK: - UseCaseProtocol (Domain)
/*
 Sendable: protocol to safty pass values between threads without data races
 */
protocol UseCaseProtocol: Sendable {
    func execute<Input, Output>(_ input: Input) async throws -> Output where Input : Sendable, Output : Sendable
    func handle<Input, Output>(input: Input) async throws -> Output where Input : Sendable, Output : Sendable
}

extension UseCaseProtocol {
    func execute<Input: Sendable, Output: Sendable>(_ input: Input) async throws -> Output {
        try await handle(input: input)
    }

    func handle<Input: Sendable, Output: Sendable>(input: Input) async throws -> Output {
        throw NSError(domain: "Not implemented. Override it in subclass.", code: 0)
    }
}
