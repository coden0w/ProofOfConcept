//
//  ApiRepository.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

@globalActor
public actor BGActor {
    public static let shared = BGActor()
}

public protocol ApiRepository: Sendable {
    
    @BGActor func getAllCharacters(requestModel: CharactersRequestDomainModel) async throws -> CharactersDomainModel
    @BGActor func getCharacterLocation(requestModel: CharacterLocationDetailRequestDomainModel) async throws -> CharacterLocationDetailDomainModel
    @BGActor func getCharacterEpisode(requestModel: CharacterEpisodeDetailRequestDomainModel) async throws -> CharacterEpisodeDetailDomainModel
}
