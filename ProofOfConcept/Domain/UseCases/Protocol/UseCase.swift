//
//  UseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

// MARK: - UseCaseProtocol (Domain)

public protocol UseCaseProtocol: Sendable {
    
    associatedtype Input: Sendable
    associatedtype Output: Sendable
    
    func handle(input: Input) async throws -> Output
}

extension UseCaseProtocol {
    public func execute(input: Input) async throws -> Output {
        try await handle(input: input)
    }
}

extension UseCaseProtocol where Input == Void {
    public func execute() async throws -> Output {
        try await handle(input: ())
    }
}
