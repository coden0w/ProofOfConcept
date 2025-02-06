//
//  CharactersModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

struct CharacterModel: Identifiable, Hashable {
    var id: Int = .zero
    var name: String = ""
    var status: String = ""
    var image: String = ""
    // Detail
    var species: String = ""
    var gender: String = ""
    var originName: String = ""
    var originId: String = ""
    var locationName: String = ""
    var locationId: String = ""
    var episodesId: [String] = []
}
