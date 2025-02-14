//
//  CharactersDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

struct CharactersDomainModel: Sendable {
    let info: CharacterInfoDomainModel
    let characters: [CharacterDomainModel]

    init(info: CharacterInfoDomainModel,
         characters: [CharacterDomainModel]) {
        self.info = info
        self.characters = characters
    }
}

struct CharacterInfoDomainModel: Sendable {
    let count: Int
    let pages: Int
    let nextUrl: String
    let prevUrl: String
}

struct CharacterDomainModel: Sendable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginDomainModel
    let location: CharacterLocationDomainModel
    let image: String
    let episodes: [String]
    let url: String
    let created: String
}

struct CharacterOriginDomainModel: Sendable {
    let name: String
    let url: String
}

struct CharacterLocationDomainModel: Sendable {
    let name: String
    let url: String
}
