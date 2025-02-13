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

    func getAllCharactersUseCase() -> GetAllCharactersUseCase {
        GetAllCharactersUseCase(repository: getApiRepository())
    }
    
    func getCharacterLocationUseCase() -> GetCharacterLocationUseCase {
        GetCharacterLocationUseCase(repository: getApiRepository())
    }
    
    func getCharacterEpisodeUseCase() -> GetCharacterEpisodeUseCase {
        GetCharacterEpisodeUseCase(repository: getApiRepository())
    }
}

extension Dependency {
    private func getApiRepository() -> ApiRepository { // Configure here the environment
        ApiRepositoryImpl(baseURL: "https://rickandmortyapi.com")
    }
}
