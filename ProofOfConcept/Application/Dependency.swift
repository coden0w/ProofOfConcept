//
//  Dependency.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

/*
 Sendable: protocol to safty pass values between threads without data races
 */
final class Dependency: Sendable {
    static let shared = Dependency()

    var getAllCharactersUseCase: GetAllCharactersUseCase {
        GetAllCharactersUseCase(repository: self.apiRepository)
    }
    
    var getCharacterLocationUseCase: GetCharacterLocationUseCase {
        GetCharacterLocationUseCase(repository: self.apiRepository)
    }
    
    var getCharacterEpisodeUseCase: GetCharacterEpisodeUseCase {
        GetCharacterEpisodeUseCase(repository: self.apiRepository)
    }
}

extension Dependency {
    private var apiRepository: ApiRepository {
        ApiRepositoryImpl(baseURL: "https://rickandmortyapi.com")
    }
}
