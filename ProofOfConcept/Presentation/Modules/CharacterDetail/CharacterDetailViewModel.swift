//
//  CharacterDetailViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation
import Combine

final class CharacterDetailViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Properties
    
    @Published var character: CharacterModel
    
    // MARK: - Dependencies
    
    // MARK: - Init
    
    init(coordinator: AppCoordinator,
         character: CharacterModel) {
        self.character = character
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() {
        super.onAppear()
    }
    
    // MARK: - NavigationFunctions
    
    func locations() {
        /// Empty
    }
    
    func episodes() {
        /// Empty
    }
    
}

extension CharacterDetailViewModel {
    static var sample: CharacterDetailViewModel {
        return CharacterDetailViewModel(coordinator: .sample, character: .init(id: 0,
                                                                               name: "Two Guys with Handlebar Mustaches",
                                                                               status: "Alive",
                                                                               image: "https://rickandmortyapi.com/api/character/avatar/370.jpeg",
                                                                               species: "Human",
                                                                               gender: "Male",
                                                                               originName: "unknown",
                                                                               originId: "1",
                                                                               locationName: "Interdimensional Cable",
                                                                               locationId: "6",
                                                                               episodesId: ["https://rickandmortyapi.com/api/episode/8"]))
    }
}
