//
//  CharactersViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

final class CharactersViewModel: BaseViewModel<AppNavigationCoordinator> {
    
    // MARK: - Properties
    
    @Published var characters: [CharactersModel] = []
    
    // MARK: - Dependencies
    
    private let getAllCharactersUseCase = Dependency.shared.getAllCharactersUseCase()
    
    // MARK: - Init
    
    init (coordinator: AppCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() {
        super.onAppear()
        getCharacters()
    }
    
    // MARK: - Navigation Functions
    
    func navigateToCharacterLocation(location: String) {
        coordinator?.showCharacterLocation(location: location)
    }
    
    // MARK: - Private Functions
    
    func getCharacters() {
        Task {
            do {
                let response = try await getAllCharactersUseCase.execute()
                self.transformModel(response.characters)
            } catch {
                print(error)
            }
        }
    }
    
    private func transformModel(_ characters: [CharacterDomainModel]) {
        self.characters = characters.map { characterDomainModel in
                .init(id: characterDomainModel.id,
                      name: characterDomainModel.name,
                      status: characterDomainModel.status,
                      image: characterDomainModel.image,
                      location: characterDomainModel.location.url)
        }
    }
    
}

extension CharactersViewModel {
    static var sample: CharactersViewModel {
        return CharactersViewModel(coordinator: .sample)
    }
}
