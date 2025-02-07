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
}

extension CharacterEpisodeDetailDataModel {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(CharacterEpisodeDetailDataModel.self, from: data)
    }
    
    func parseToDomainModel() -> CharacterEpisodeDetailDomainModel {
        return CharacterEpisodeDetailDomainModel(
            id: id ?? .zero,
            name: name ?? "",
            onAir: onAir ?? "",
            episode: episode ?? "",
            characters: characters ?? [],
            url: url ?? "",
            created: created ?? "")
    }
}
