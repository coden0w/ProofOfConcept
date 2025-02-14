//
//  DataTest.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 14/2/25.
//

import Foundation
@testable import ProofOfConcept

var mockCharacters: CharactersDomainModel {
    CharactersDomainModel(info: mockInfo,
                          characters: [mockCharacter])
}
let mockInfo: CharacterInfoDomainModel = CharacterInfoDomainModel(count: 1,
                                                                  pages: 1,
                                                                  nextUrl: "",
                                                                  prevUrl: "")
let mockCharacter: CharacterDomainModel = CharacterDomainModel(id: 1,
                                                               name: "TEST",
                                                               status: "",
                                                               species: "",
                                                               type: "",
                                                               gender: "",
                                                               origin: .init(name: "", url: ""),
                                                               location: .init(name: "", url: ""),
                                                               image: "",
                                                               episodes: [],
                                                               url: "",
                                                               created: "")
let mockCharacterLocationDetail: CharacterLocationDetailDomainModel = CharacterLocationDetailDomainModel(id: 1,
                                                                                                         name: "TEST",
                                                                                                         type: "",
                                                                                                         dimension: "",
                                                                                                         residents: [],
                                                                                                         url: "",
                                                                                                         created: "")
let mockCharacterEpisodeDetail: CharacterEpisodeDetailDomainModel = CharacterEpisodeDetailDomainModel(id: 1,
                                                                                                      name: "TEST",
                                                                                                      onAir: "",
                                                                                                      episode: "",
                                                                                                      characters: [],
                                                                                                      url: "",
                                                                                                      created: "")
struct TestModel: Codable, Equatable {
    let id: Int
    let name: String
}
