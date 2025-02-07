//
//  CharacterEpisodeDetailRequestDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation

public struct CharacterEpisodeDetailRequestDomainModel: Sendable {
    
    public let episode: String
    
    public init(episode: String) {
        self.episode = episode
    }
}
