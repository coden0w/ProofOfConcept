//
//  Dependency.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

/*
 Sendable: protocol to safty pass values between threads without data races
 */
final class Dependency: Sendable {
    
    static let shared = Dependency()
    
    internal init() {
        // Empty
    }
    
    func getAllCharactersUseCase() -> GetAllCharactersUseCase {
        return GetAllCharactersUseCase(repository: getApiRepository())
    }
    
    func getCharacterLocationUseCase() -> GetCharacterLocationUseCase {
        return GetCharacterLocationUseCase(repository: getApiRepository())
    }
    
    func getCharacterEpisodeUseCase() -> GetCharacterEpisodeUseCase {
        return GetCharacterEpisodeUseCase(repository: getApiRepository())
    }
}
extension Dependency {
    
    private func getApiRepository() -> ApiRepository { // Configure here the environment
        return ApiRepositoryImpl(baseURL: "https://rickandmortyapi.com")
    }
}
