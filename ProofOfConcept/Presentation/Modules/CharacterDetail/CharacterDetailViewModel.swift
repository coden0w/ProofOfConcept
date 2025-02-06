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
    @Published var origin: LocationModel = .init()
    @Published var location: LocationModel = .init()
    @Published var episode: EpisodeModel = .init()
    
    // MARK: - Dependencies
    
    private let getCharacterLocationUseCase: GetCharacterLocationUseCase = Dependency.shared.getCharacterLocationUseCase()
    private let getCharacterEpisodeUseCase: GetCharacterEpisodeUseCase = Dependency.shared.getCharacterEpisodeUseCase()
    
    // MARK: - Init
    
    init(coordinator: AppCoordinator,
         character: CharacterModel) {
        self.character = character
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() async {
        await super.onAppear()
        locations()
        episodes()
    }
    
    // MARK: - NavigationFunctions
    
    func locations() {
        Task {
            do {
                let responseOrigin = try await self.getCharacterLocationUseCase.execute(.init(location: self.character.originId))
                self.transformLocationModel(responseOrigin)
                let responseLocation = try await self.getCharacterLocationUseCase.execute(.init(location: self.character.locationId))
                self.transformLocationModel(responseLocation, isOrigin: false)
            } catch {
                print(error)
            }
        }
    }
    
    func episodes() {
        Task {
            do {
                guard let episodeId = self.character.episodesId.first else { return }
                let response = try await self.getCharacterEpisodeUseCase.execute(.init(episode: episodeId))
                self.transformEpisodeModel(response)
            } catch {
                print(error)
            }
        }
    }
    
    private func transformLocationModel(_ response: CharacterLocationDetailDomainModel, isOrigin: Bool = true) {
        if isOrigin {
            origin = .init(name: response.name,
                             type: response.type,
                             dimension: response.dimension,
                             residents: response.residents.count,
                             isOrigin: isOrigin)
        } else {
            location = .init(name: response.name,
                             type: response.type,
                             dimension: response.dimension,
                             residents: response.residents.count,
                             isOrigin: isOrigin)
        }
    }
    
    private func transformEpisodeModel(_ response: CharacterEpisodeDetailDomainModel) {
        episode = .init(name: response.name,
                        airDate: response.onAir,
                        episode: response.episode)
    }
    
}

extension CharacterDetailViewModel {
    static var sample: CharacterDetailViewModel {
        return CharacterDetailViewModel(coordinator: .sample, character: .init(id: 1,
                                                                               name: "Rick Sanchez",
                                                                               status: "Alive",
                                                                               image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                                                               species: "Human",
                                                                               gender: "Male",
                                                                               originName: "Earth (C-137)",
                                                                               originId: "1",
                                                                               locationName: "Citadel of Ricks",
                                                                               locationId: "3",
                                                                               episodesId: ["https://rickandmortyapi.com/api/episode/28",
                                                                                            "https://rickandmortyapi.com/api/episode/51"]))
    }
}
