//
//  CharactersViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine

final class CharactersViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Properties
    
    @Published var characters: [CharactersModel] = []
    @Published var page: Int = .zero
    
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
    
    func details(_ id: Int) {
//        coordinator?.showCharacterLocation(location: location)
    }
    
    // MARK: - Action Functions
    
    func nextPage() {
        self.page += 1
        getCharacters()
    }
    
    func previewPage() {
        self.page -= 1
        getCharacters()
    }
    
    // MARK: - Private Functions
    
    private func getCharacters() {
        Task {
            do {
                let response = try await getAllCharactersUseCase.execute(.init(page: self.page))
                self.page = self.getPage(response.info.nextUrl)
                self.transformModel(response.characters)
            } catch {
                print(error)
            }
        }
    }
    
    private func getPage(_ nextUrl: String) -> Int {
        if let range = nextUrl.range(of: "page=(\\d+)", options: .regularExpression),
           let pageNr = Int(nextUrl[range].replacingOccurrences(of: "page=", with: "")) {
            return pageNr - 1
        } else {
            return .zero
        }
    }
    
    private func transformModel(_ characters: [CharacterDomainModel]) {
        self.characters = characters.map { characterDomainModel in
                .init(id: characterDomainModel.id,
                      name: characterDomainModel.name,
                      status: characterDomainModel.status,
                      image: characterDomainModel.image)
        }
    }
    
}

extension CharactersViewModel {
    static var sample: CharactersViewModel {
        return CharactersViewModel(coordinator: .sample)
    }
}
