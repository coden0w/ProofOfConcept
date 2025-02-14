//
//  GetCharacterEpisodeUseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation

actor GetCharacterEpisodeUseCase: UseCaseProtocol {
    private let repository: ApiRepository

    init(repository: ApiRepository = ApiRepositoryImpl()) {
        self.repository = repository
    }

    func execute<Input, Output>(_ input: Input) async throws -> Output where Input : Sendable, Output : Sendable {
        guard let input = input as? CharacterEpisodeDetailRequestDomainModel,
              let output = try await repository.getCharacterEpisode(requestModel: input) as? Output else {
            fatalError("Unable to cast output")
        }
        return output
    }
}
