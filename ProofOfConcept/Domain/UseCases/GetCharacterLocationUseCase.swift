//
//  GetCharacterLocationUseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import Combine

final class GetCharacterLocationUseCase: UseCaseProtocol<CharacterLocationDetailRequestDomainModel, CharacterLocationDetailDomainModel> {
    
    private let repository: ApiRepository
    
    public init(repository: ApiRepository) {
        self.repository = repository
    }
    
    override func handle(input: CharacterLocationDetailRequestDomainModel) async throws -> CharacterLocationDetailDomainModel {
        print("🚀 GetCharacterDetailUseCase")
        return try await repository.getCharacterLocation(requestModel: input)
    }
}
