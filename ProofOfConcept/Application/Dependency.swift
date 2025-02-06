//
//  Dependency.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine
/*
 DISCARD: NOT POSSIBLE TO SEND ASYNC DATA THROUGH PROPERTY WRAPPERS.
 
@propertyWrapper
actor Injected<T: Sendable> {
    
    internal init() {
        // Empty
    }
    
    @MainActor var wrappedValue: T {
        var dependency: T
        switch T.self {
        case is GetAllCharactersUseCase.Type:
            dependency = Dependency.shared.getAllCharactersUseCase() as! T
        case is GetCharacterDetailUseCase.Type:
            dependency = Dependency.shared.getCharacterDetailUseCase() as! T
        default:
            fatalError("Dependency \(T.self) does not exists")
        }
        return dependency
    }
}
*/

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
    
    func getCharacterDetailUseCase() -> GetCharacterDetailUseCase {
        return GetCharacterDetailUseCase(repository: getApiRepository())
    }
}
extension Dependency {
    
    private func getApiRepository() -> ApiRepository { // Configure here the environment
        return ApiRepositoryImpl(baseURL: "https://rickandmortyapi.com")
    }
}
