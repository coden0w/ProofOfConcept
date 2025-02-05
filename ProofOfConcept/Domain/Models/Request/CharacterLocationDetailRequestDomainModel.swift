//
//  CharacterLocationDetailRequestDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

public struct CharacterLocationDetailRequestDomainModel: Sendable {
    
    public let location: String
    
    public init(location: String) {
        self.location = location
    }
}
