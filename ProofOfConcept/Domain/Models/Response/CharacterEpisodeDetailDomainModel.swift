//
//  CharacterEpisodeDetailDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation

struct CharacterEpisodeDetailDomainModel: Sendable {
    let id: Int
    let name: String
    let onAir: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    init(id: Int,
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
