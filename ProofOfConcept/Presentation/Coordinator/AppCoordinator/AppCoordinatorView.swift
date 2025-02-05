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
                    if let path = hashable as? AppCoordinator.Path {
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
    
    @MainActor @ViewBuilder
    private func buildPathDestionation(path: AppCoordinator.Path) -> some View {
        switch path {
        case .characters:
            charactersView()
        case .characterLocation(let location):
            characterLocationView(location: location)
        }
    }
    
    @MainActor @ViewBuilder func initialView() -> some View {
        RootView(viewModel: RootViewModel(coordinator: coordinator))
    }
    
    @MainActor @ViewBuilder func charactersView() -> some View {
        CharactersView(viewModel: CharactersViewModel(coordinator: coordinator))
    }
    
    @MainActor @ViewBuilder func characterLocationView(location: String) -> some View {
        CharacterLocationView(viewModel: CharacterLocationViewModel(coordinator: coordinator, location: location))
    }
}
