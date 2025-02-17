//
//  GetCharacterLocationUseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

actor GetCharacterLocationUseCase: UseCaseProtocol {
    private let repository: ApiRepository

    init(repository: ApiRepository) {
        self.repository = repository
    }

    func execute<Input, Output>(_ input: Input) async throws -> Output where Input : Sendable, Output : Sendable {
        guard let input = input as? CharacterLocationDetailRequestDomainModel,
              let output = try await repository.getCharacterLocation(requestModel: input) as? Output else {
            fatalError("Unable to cast output")
        }
        return output
    }
}
