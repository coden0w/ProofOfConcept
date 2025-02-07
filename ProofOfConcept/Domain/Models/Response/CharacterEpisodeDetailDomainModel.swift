//
//  CharacterEpisodeDetailDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation

public struct CharacterEpisodeDetailDomainModel: Sendable {
    
    public let id: Int
    public let name: String
    public let onAir: String
    public let episode: String
    public let characters: [String]
    public let url: String
    public let created: String
    
    public init(id: Int,
                name: String,
                onAir: String,
                episode: String,
                characters: [String],
                url: String,
                created: String) {
        self.id = id
        self.name = name
        self.onAir = onAir
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }
}
