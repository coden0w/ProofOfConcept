//
//  CharacterLocationDetailDomainModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

public struct CharacterLocationDetailDomainModel {
    
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [String]
    public let url: String
    public let created: String
    
    public init(id: Int,
                name: String,
                type: String,
                dimension: String,
                residents: [String],
                url: String,
                created: String) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
        self.created = created
    }
}
