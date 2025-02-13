//
//  CharactersViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation

@MainActor
final class CharactersViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Publishers
    
    @Published var characters: [CharacterModel] = []
    @Published var page: Int = .zero
    
    // MARK: - Dependencies
    
    private var getAllCharactersUseCase: GetAllCharactersUseCase
    
    // MARK: - Init
    
    init(coordinator: AppCoordinator,
         getAllCharactersUseCase: GetAllCharactersUseCase = Dependency.shared.getAllCharactersUseCase) {
        self.getAllCharactersUseCase = getAllCharactersUseCase
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() async {
        await super.onAppear()
        getCharacters()
    }
    
    // MARK: - Navigation Functions
    
    func details(_ id: Int) {
        if let model = characters.first(where: { $0.id == id }) {
            coordinator?.showCharacterDetail(model)
        }
    }
    
    // MARK: - Action Functions
    
    func nextPage() {
        page += 1
        getCharacters()
    }
    
    func previewPage() {
        page -= 1
        getCharacters()
    }
    
    // MARK: - Private Functions
    
    private func getCharacters() {
        Task {
            do {
                let response: CharactersDomainModel = try await self.getAllCharactersUseCase.execute(CharactersRequestDomainModel(page: self.page))
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
        let aux: [CharacterModel] = characters.map { characterDomainModel in
                .init(id: characterDomainModel.id,
                      name: characterDomainModel.name,
                      status: characterDomainModel.status,
                      image: characterDomainModel.image,
                      species: characterDomainModel.species,
                      gender: characterDomainModel.gender,
                      originName: characterDomainModel.origin.name,
                      originId: getId(characterDomainModel.origin.url),
                      locationName: characterDomainModel.location.name,
                      locationId: getId(characterDomainModel.location.url),
                      episodesId: characterDomainModel.episodes)
        }
        
        self.characters = aux
    }
    
    private func getId(_ url: String) -> String {
        let splitUrl = url.split(separator: "/")
        return String(splitUrl.last ?? "")
    }
    
}

extension CharactersViewModel {
    static var sample: CharactersViewModel {
        CharactersViewModel(coordinator: .sample)
    }
}
