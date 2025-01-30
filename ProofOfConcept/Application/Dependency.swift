//
//  Dependency.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

// MARK: - Dependency Injector (ProofOfConcept)

@propertyWrapper
class Dependency<T: Sendable> {
    
    init() {
        // Empty
    }
    
    var wrappedValue: T {
        var dependency: T
        
        switch T.self {
        case is GetAllCharactersUseCase.Type:
            dependency = GetAllCharactersUseCase(repository: getApiRepository()) as! T
        case is GetCharacterDetailUseCase.Type:
            dependency = GetCharacterDetailUseCase(repository: getApiRepository()) as! T
        default:
            fatalError("Dependency \(T.self) does not exists")
        }
        
        return dependency
    }
}

extension Dependency {
    
    private func getApiRepository() -> ApiRepository { // Configure here the environment
        return ApiRepositoryImpl(baseURL: "https://rickandmortyapi.com")
    }
}
