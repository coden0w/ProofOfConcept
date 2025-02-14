//
//  GetAllCharactersUseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

actor GetAllCharactersUseCase: UseCaseProtocol {
    private let repository: ApiRepository

    init(repository: ApiRepository = ApiRepositoryImpl()) {
        self.repository = repository
    }

    func execute<Input, Output>(_ input: Input) async throws -> Output where Input : Sendable, Output : Sendable {
        guard let input = input as? CharactersRequestDomainModel,
              let output = try await repository.getAllCharacters(requestModel: input) as? Output else {
            fatalError("Unable to cast output")
        }
        return output
    }
}
