//
//  GetCharacterEpisodeUseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation
import Combine

final class GetCharacterEpisodeUseCase: UseCaseProtocol<CharacterEpisodeDetailRequestDomainModel, CharacterEpisodeDetailDomainModel> {
    
    private let repository: ApiRepository
    
    public init(repository: ApiRepository) {
        self.repository = repository
    }
    
    override func handle(input: CharacterEpisodeDetailRequestDomainModel) async throws -> CharacterEpisodeDetailDomainModel {
        return try await repository.getCharacterEpisode(requestModel: input)
    }
}
