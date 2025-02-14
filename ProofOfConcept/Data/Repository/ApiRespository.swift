//
//  ApiRepositoryImpl.swift
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

actor ApiRepositoryImpl: ApiRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient = DefaultAPIClient()) {
        self.apiClient = apiClient
    }

    func getAllCharacters(requestModel: CharactersRequestDomainModel) async throws -> CharactersDomainModel {
        try await self.apiClient.request(CharactersDataModel.get(page: requestModel.page.description))
            .toParseToDomainModel
    }
    
    func getCharacterLocation(requestModel: CharacterLocationDetailRequestDomainModel) async throws -> CharacterLocationDetailDomainModel {
        try await self.apiClient.request(CharacterLocationDetailDataModel.get(location: requestModel.location))
            .toParseToDomainModel
    }
    
    func getCharacterEpisode(requestModel: CharacterEpisodeDetailRequestDomainModel) async throws -> CharacterEpisodeDetailDomainModel {
        try await self.apiClient.request(CharacterEpisodeDetailDataModel.get(episode: requestModel.episode))
            .toParseToDomainModel
    }
}
