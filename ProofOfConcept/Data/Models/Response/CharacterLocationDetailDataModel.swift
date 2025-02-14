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
    
    static func get(location: String) throws -> Resource<CharacterLocationDetailDataModel> {
        guard let url = try URL.fetch(path: "/api/location/\(location)/") else {
            throw NetworkError.badUrl
        }
        return Resource(url: url)
    }
}

extension CharacterLocationDetailDataModel {
    var toParseToDomainModel: CharacterLocationDetailDomainModel {
        CharacterLocationDetailDomainModel(id: id ?? .zero,
                                           name: name ?? "",
                                           type: type ?? "",
                                           dimension: dimension ?? "",
                                           residents: residents ?? [],
                                           url: url ?? "",
                                           created: created ?? "")
    }
}
