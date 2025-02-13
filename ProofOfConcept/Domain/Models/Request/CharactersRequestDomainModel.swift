//
//  CharactersRequestDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 5/2/25.
//

import Foundation

struct CharactersRequestDomainModel: Sendable {
    let page: Int

    init(page: Int) {
        self.page = page
    }
}
