//
//  GetAllCharactersUseCase.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

final class GetAllCharactersUseCase: UseCaseProtocol {
    
    private let repository: ApiRepository
    
    public init(repository: ApiRepository) {
        self.repository = repository
    }
    
    public func handle(input: Void) async throws -> CharactersDomainModel {
        print("🚀 GetAllCharactersUseCase")
        return try await repository.getAllCharacters()
    }
}
