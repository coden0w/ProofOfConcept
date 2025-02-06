//
//  AppCoordinatorView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import SwiftUI

struct AppCoordinatorView: View {
    
    @State var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            initialView()
                .navigationDestination(for: AnyHashable.self) { hashable in
                    if let path = hashable as? ScreenPath {
                        buildPathDestionation(path: path)
                    } else {
                        Text("")
                            .onAppear {
                                assertionFailure("❌ Unexpected navigation destination received!")
                            }
                    }
                }
        }
    }
}

extension AppCoordinatorView {
    
    @ViewBuilder
    private func buildPathDestionation(path: ScreenPath) -> some View {
        switch path {
        case .characters:
            charactersView()
        case .characterDetail(let model):
            characterDetailView(model: model)
        }
    }
    
    @ViewBuilder func initialView() -> some View {
        RootView(viewModel: RootViewModel(coordinator: coordinator))
    }
    
    @ViewBuilder func charactersView() -> some View {
        CharactersView(viewModel: CharactersViewModel(coordinator: coordinator))
    }
    
    @ViewBuilder func characterDetailView(model: CharacterModel) -> some View {
        CharacterDetailView(viewModel: CharacterDetailViewModel(coordinator: coordinator, character: model))
    }
}
