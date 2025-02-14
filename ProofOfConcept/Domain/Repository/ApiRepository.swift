//
//  ApiRepository.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

protocol ApiRepository: Sendable {
    func getAllCharacters(requestModel: CharactersRequestDomainModel) async throws -> CharactersDomainModel
    func getCharacterLocation(requestModel: CharacterLocationDetailRequestDomainModel) async throws -> CharacterLocationDetailDomainModel
    func getCharacterEpisode(requestModel: CharacterEpisodeDetailRequestDomainModel) async throws -> CharacterEpisodeDetailDomainModel
}
