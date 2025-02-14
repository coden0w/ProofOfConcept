//
//  CharacterEpisodeDetailRequestDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation

struct CharacterEpisodeDetailRequestDomainModel: Sendable {
    
    let episode: String
    
    init(episode: String) {
        self.episode = episode
    }
}
