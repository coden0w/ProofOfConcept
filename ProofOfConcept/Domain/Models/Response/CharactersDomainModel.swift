//
//  CharactersDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

public struct CharactersDomainModel {
    
    public let info: CharacterInfoDomainModel
    public let characters: [CharacterDomainModel]
    
    public init(info: CharacterInfoDomainModel,
                characters: [CharacterDomainModel]) {
        self.info = info
        self.characters = characters
    }
}

public struct CharacterInfoDomainModel {
    public let count: Int
    public let pages: Int
    public let nextUrl: String
}

public struct CharacterDomainModel {
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

public struct CharacterOriginDomainModel {
    public let name: String
    public let url: String
}

public struct CharacterLocationDomainModel {
    public let name: String
    public let url: String
}
