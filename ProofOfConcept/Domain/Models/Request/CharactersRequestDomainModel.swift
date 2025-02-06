//
//  CharactersRequestDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 5/2/25.
//

import Foundation

public struct CharactersRequestDomainModel: Sendable {
    
    public let page: Int
    
    public init(page: Int) {
        self.page = page
    }
}
