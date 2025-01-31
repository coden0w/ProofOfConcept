//
//  AppCoordinatorView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import SwiftUI

struct AppCoordinatorView: View {
    
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            initialView
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
    
    @ViewBuilder
    private func buildPathDestionation(path: AppCoordinator.Path) -> some View {
        switch path {
        case .characters:
            charactersView
        case .characterLocation(let location):
            characterLocationView(location: location)
        }
    }
}

// MARK: - ViewBuilders

extension AppCoordinatorView {
    
    @ViewBuilder var initialView: some View {
        RootView(viewModel: .init(coordinator: coordinator))
    }
    
    @ViewBuilder var charactersView: some View {
        CharactersView(viewModel: .init(coordinator: coordinator))
    }
    
    @ViewBuilder func characterLocationView(location: String) -> some View {
        CharacterLocationView(viewModel: .init(coordinator: coordinator, location: location))
    }
}
