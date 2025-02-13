//
//  CharacterLocationDetailDataModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

struct CharacterLocationDetailDataModel: Codable {
    
    let id: Int?
    let name: String?
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}

extension CharacterLocationDetailDataModel {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(CharacterLocationDetailDataModel.self, from: data)
    }
    
    func parseToDomainModel() -> CharacterLocationDetailDomainModel {
        CharacterLocationDetailDomainModel(id: id ?? .zero,
                                           name: name ?? "",
                                           type: type ?? "",
                                           dimension: dimension ?? "",
                                           residents: residents ?? [],
                                           url: url ?? "",
                                           created: created ?? "")
    }
}
