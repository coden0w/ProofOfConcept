//
//  GetAllCharactersUseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

final class GetAllCharactersUseCase: UseCaseProtocol<CharactersRequestDomainModel, CharactersDomainModel> {
    
    private let repository: ApiRepository
    
    public init(repository: ApiRepository) {
        self.repository = repository
    }
    
    override func handle(input: CharactersRequestDomainModel) async throws -> CharactersDomainModel {
        print("🚀 GetAllCharactersUseCase")
        return try await repository.getAllCharacters(requestModel: input)
    }
}
