//
//  CharactersViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

class CharactersViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    @Published var characters: [CharactersModel] = []
    
    // MARK: - Dependencies
    
    @Dependency private var getAllCharactersUseCase: GetAllCharactersUseCase
    
    // MARK: - Init
    
    override init () {
        // Empty
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() {
        super.onAppear()
        getCharacters()
    }
    
    override func onDisappear() {
        super.onDisappear()
        // remove if not needed
    }
    
    // MARK: - Private Functions
    
    private func getCharacters() {
        Task {
            do {
                let response = try await self.getAllCharactersUseCase.execute()
                self.transformModel(response.characters)
            } catch {
                print(error)
            }
        }
    }
    
    private func transformModel(_ characters: [CharacterDomainModel]) {
        DispatchQueue.main.async {
            self.characters = characters.map { characterDomainModel in
                    .init(id: characterDomainModel.id,
                          name: characterDomainModel.name,
                          status: characterDomainModel.status,
                          image: characterDomainModel.image)
            }
        }
    }
    
}

extension CharactersViewModel {
    static var sample: CharactersViewModel {
        return CharactersViewModel()
    }
}
