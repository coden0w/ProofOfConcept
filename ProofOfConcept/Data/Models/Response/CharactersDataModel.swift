//
//  CharactersDataModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

struct CharactersDataModel: Codable {
    
    let info: CharacterInfoDataModel?
    let characters: [CharacterDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case characters = "results"
    }
    
}

extension CharactersDataModel {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(CharactersDataModel.self, from: data)
    }
    
    func parseToDomainModel() -> CharactersDomainModel {
        
        let characterInfoDomainModel = CharacterInfoDomainModel(count: info?.count ?? .zero,
                                                                pages: info?.pages ?? .zero,
                                                                nextUrl: info?.next ?? "",
                                                                prevUrl: info?.prev ?? "")
        
        let charactersDomainModel: [CharacterDomainModel] = characters?.compactMap({ characterDataModel in
            characterDataModel.parseToDomainModel()
        }) ?? []
        
        return CharactersDomainModel(info: characterInfoDomainModel,
                                     characters: charactersDomainModel)
    }
}

struct CharacterInfoDataModel: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
    
    enum CondingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
}

struct CharacterDataModel: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: CharacterOriginDataModel?
    let location: CharacterLocationDataModel?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

extension CharacterDataModel {
    
    func parseToDomainModel() -> CharacterDomainModel {
        let originDomainModel: CharacterOriginDomainModel = .init(name: origin?.name ?? "",
                                                                  url: origin?.url ?? "")
        
        let locationDomainModel: CharacterLocationDomainModel = .init(name: location?.name ?? "",
                                                                      url: location?.url ?? "")
        
        return CharacterDomainModel(id: id ?? .zero,
                                    name: name ?? "",
                                    status: status ?? "",
                                    species: species ?? "",
                                    type: type ?? "",
                                    gender: gender ?? "",
                                    origin: originDomainModel,
                                    location: locationDomainModel,
                                    image: image ?? "",
                                    episodes: episode ?? [],
                                    url: url ?? "",
                                    created: created ?? "")
    }
}

struct CharacterOriginDataModel: Codable {
    let name: String?
    let url: String?
}

struct CharacterLocationDataModel: Codable {
    let name: String?
    let url: String?
}
