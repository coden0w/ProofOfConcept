//
//  UseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

// MARK: - UseCaseProtocol (Domain)

@preconcurrency
open class UseCaseProtocol<Input, Output>: @unchecked Sendable {
    
    public init() {
        // Empty
    }
        
    open func execute(_ input: Input) async throws -> Output {
        try await handle(input: input)
    }
    
    open func handle(input: Input) async throws -> Output {
        throw NSError(domain: "Not implemented. Override it in subclass.", code: 0)
    }
}

extension UseCaseProtocol where Input == Void {
    
    public func execute() async throws -> Output {
        try await execute(())
    }
}
