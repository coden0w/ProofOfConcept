//
//  CharactersDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

public struct CharactersDomainModel: Sendable {
    
    public let info: CharacterInfoDomainModel
    public let characters: [CharacterDomainModel]
    
    public init(info: CharacterInfoDomainModel,
                characters: [CharacterDomainModel]) {
        self.info = info
        self.characters = characters
    }
}

public struct CharacterInfoDomainModel: Sendable {
    public let count: Int
    public let pages: Int
    public let nextUrl: String
    public let prevUrl: String
}

public struct CharacterDomainModel: Sendable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: CharacterOriginDomainModel
    public let location: CharacterLocationDomainModel
    public let image: String
    public let episodes: [String]
    public let url: String
    public let created: String
}

public struct CharacterOriginDomainModel: Sendable {
    public let name: String
    public let url: String
}

public struct CharacterLocationDomainModel: Sendable {
    public let name: String
    public let url: String
}
