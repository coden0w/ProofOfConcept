//
//  CharacterDetailViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation

final class CharacterDetailViewModel: BaseViewModel<AppCoordinatorProtocol> {
    @Published var character: CharacterModel
    @Published var origin: LocationModel = .init()
    @Published var location: LocationModel = .init()
    @Published var episode: EpisodeModel = .init()
    
    private let getCharacterLocationUseCase: GetCharacterLocationUseCase
    private let getCharacterEpisodeUseCase: GetCharacterEpisodeUseCase
    
    init(coordinator: AppCoordinator,
         character: CharacterModel,
         getCharacterLocationUseCase: GetCharacterLocationUseCase = GetCharacterLocationUseCase(),
         getCharacterEpisodeUseCase: GetCharacterEpisodeUseCase = GetCharacterEpisodeUseCase()) {
        self.character = character
        self.getCharacterLocationUseCase = getCharacterLocationUseCase
        self.getCharacterEpisodeUseCase = getCharacterEpisodeUseCase
        super.init(coordinator: coordinator)
    }
    
    override func onAppear() async {
        await super.onAppear()
        locations()
        episodes()
    }
    
    func locations() {
        Task {
            do {
                let responseOrigin: CharacterLocationDetailDomainModel = try await self.getCharacterLocationUseCase.execute(CharacterLocationDetailRequestDomainModel(location: self.character.originId))
                self.transformLocationModel(responseOrigin)
                let responseLocation: CharacterLocationDetailDomainModel = try await self.getCharacterLocationUseCase.execute(CharacterLocationDetailRequestDomainModel(location: self.character.locationId))
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
                let response: CharacterEpisodeDetailDomainModel = try await self.getCharacterEpisodeUseCase.execute(CharacterEpisodeDetailRequestDomainModel(episode: episodeId))
                self.transformEpisodeModel(response)
            } catch {
                print(error)
            }
        }
    }
}

extension CharacterDetailViewModel {
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
        CharacterDetailViewModel(coordinator: .sample, character: .init(id: 1,
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
