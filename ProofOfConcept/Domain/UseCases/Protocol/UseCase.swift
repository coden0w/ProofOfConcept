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
}
