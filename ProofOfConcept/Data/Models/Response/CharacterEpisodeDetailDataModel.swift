//
//  CharacterEpisodeDetailDataModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation

struct CharacterEpisodeDetailDataModel: Codable {
    let id: Int?
    let name: String?
    let onAir: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case onAir = "air_date"
        case episode
        case characters
        case url
        case created
    }
    
    static func get(episode: String) throws -> Resource<CharacterEpisodeDetailDataModel> {
        guard let url = try URL.fetch(path: "/api/episode/\(episode)/") else {
            throw NetworkError.badUrl
        }
        return Resource(url: url)
    }
}

extension CharacterEpisodeDetailDataModel {
    var toParseToDomainModel: CharacterEpisodeDetailDomainModel {
        CharacterEpisodeDetailDomainModel(
            id: id ?? .zero,
            name: name ?? "",
            onAir: onAir ?? "",
            episode: episode ?? "",
            characters: characters ?? [],
            url: url ?? "",
            created: created ?? "")
    }
}
