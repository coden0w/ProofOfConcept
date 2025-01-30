//
//  CharacterLocationViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import Combine

class CharacterLocationViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private let coordinator: AppCoordinator
    private let location: String
    @Published var characterLocationModel: CharacterLocationModel = .init()
    
    // MARK: - Dependencies
    
    @Dependency private var getCharacterDetailUseCase: GetCharacterDetailUseCase
    
    // MARK: - Init
    
    init(coordinator: AppCoordinator,
         location: String) {
        self.coordinator = coordinator
        self.location = location
        super.init()
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() {
        getCharacterDetail()
    }
    
    // MARK: - Private Functions
    
    private func getCharacterDetail() {
        Task {
            do {
                let response = try await self.getCharacterDetailUseCase.execute(input: .init(location: self.location))
                await self.transformModel(response)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    private func transformModel(_ response: CharacterLocationDetailDomainModel) {
        self.characterLocationModel = .init(name: response.name,
                                            type: response.type,
                                            dimension: response.dimension,
                                            residents: self.transformResidentsToImage(response.residents),
                                            image: self.transformCharacterToImage(response.url))
        
    }
    
    private func transformResidentsToImage(_ residents: [String]) -> [String] {
        return residents.map { resident in
            let residentImage = resident.replacingOccurrences(of: "/character/", with: "/character/avatar/") + ".jpeg"
            return residentImage
        }
    }
    
    private func transformCharacterToImage(_ url: String) -> String {
        let characterImage = url.replacingOccurrences(of: "/character/", with: "/character/avatar/") + ".jpeg"
        return characterImage
    }
}

extension CharacterLocationViewModel {
    static var sample: CharacterLocationViewModel {
        return CharacterLocationViewModel(coordinator: .sample, location: "")
    }
}
