//
//  CharacterLocationDetailRequestDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

struct CharacterLocationDetailRequestDomainModel: Sendable {
    let location: String

    init(location: String) {
        self.location = location
    }
}
