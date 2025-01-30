//
//  ApiRepository.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

@globalActor
public actor BGActor {
    public static let shared = BGActor()
}

public protocol ApiRepository {
    
    @BGActor func getAllCharacters() async throws -> CharactersDomainModel
    @BGActor func getCharacterDetail(requestModel: CharacterLocationDetailRequestDomainModel) async throws -> CharacterLocationDetailDomainModel
}
