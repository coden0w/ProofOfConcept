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
    
    private let location: String
    var characterLocationModel: CharacterLocationModel = .init()
    // MARK: - Dependencies
    
    @Dependency private var getCharacterDetailUseCase: GetCharacterDetailUseCase
    
    // MARK: - Init
    
    init(location: String) {
        self.location = location
        super.init()
        getCharacterDetail()
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() {
        super.onAppear()
        // remove if not needed
    }
    
    override func onDisappear() {
        super.onDisappear()
    }
    
    // MARK: - Private Functions
    
    private func getCharacterDetail() {
        Task {
            do {
                let response = try await self.getCharacterDetailUseCase.execute(input: .init(location: self.location))
                self.transformModel(response)
            } catch {
                print(error)
            }
        }
    }
    
    private func transformModel(_ response: CharacterLocationDetailDomainModel) {
        print(response)
        DispatchQueue.main.async {
            self.characterLocationModel = .init(name: response.name,
                                                type: response.type,
                                                dimension: response.dimension,
                                                residents: self.transformResidentsToImage(response.residents),
                                                image: self.transformCharacterToImage(response.url))
        }
    }
    
    private func transformResidentsToImage(_ residents: [String]) -> [String] {
        return residents.map { resident in //
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
        return CharacterLocationViewModel(location: "")
    }
}
