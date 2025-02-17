//
//  MockApiRepository.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
@testable import ProofOfConcept

actor MockApiRepository: ApiRepository {
    func getAllCharacters(requestModel: CharactersRequestDomainModel) async throws -> CharactersDomainModel {
        mockCharacters
    }
    
    func getCharacterLocation(requestModel: CharacterLocationDetailRequestDomainModel) async throws -> CharacterLocationDetailDomainModel {
        mockCharacterLocationDetail
    }
    
    func getCharacterEpisode(requestModel: CharacterEpisodeDetailRequestDomainModel) async throws -> CharacterEpisodeDetailDomainModel {
        mockCharacterEpisodeDetail
    }
}
