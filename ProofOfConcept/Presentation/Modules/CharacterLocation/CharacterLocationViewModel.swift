//
//  CharacterLocationViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import Combine

final class CharacterLocationViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Properties
    
    private let location: String
    @Published var characterLocationModel: CharacterLocationModel = .init()
    
    // MARK: - Dependencies
    
    private let getCharacterDetailUseCase = Dependency.shared.getCharacterDetailUseCase()
    
    // MARK: - Init
    
    init(coordinator: AppCoordinator,
         location: String) {
        self.location = location
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() async {
        await super.onAppear()
        getCharacterDetail()
    }
    
    // MARK: - Private Functions
    
    private func getCharacterDetail() {
        Task {
            do {
                let response = try await getCharacterDetailUseCase.execute(.init(location: self.location))
                self.transformModel(response)
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
                                            residents: self.transformResidentsToImage(response.residents))
        
    }
    
    private func transformResidentsToImage(_ residents: [String]) -> [String] {
        return residents.map { resident in
            let residentImage = resident.replacingOccurrences(of: "/character/", with: "/character/avatar/") + ".jpeg"
            return residentImage
        }
    }
    
    // MARK: - Navigation Functions
    
    func popToRoot() {
        coordinator?.popToRoot()
    }
}

extension CharacterLocationViewModel {
    static var sample: CharacterLocationViewModel {
        return CharacterLocationViewModel(coordinator: .sample, location: "")
    }
}
