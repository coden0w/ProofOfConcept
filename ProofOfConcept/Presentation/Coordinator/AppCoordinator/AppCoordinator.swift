//
//  AppCoordinator.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import SwiftUI
import Combine

protocol AppNavigationCoordinator {
    func showCharacters()
    func showCharacterLocation(location: String)
}

@Observable
final class AppCoordinator: Identifiable {
    
    // MARK: - Navigation Paths
    
    enum Path: Hashable {
        case characters
        case characterLocation(String)
    }
    
    // MARK: - Properties
    
    var navigationPath = [AnyHashable]()
    private var subscriptions = [AnyCancellable]()
    
    init() {
        // Empty
    }
    
    @MainActor @ViewBuilder
    func buildPathDestionation(path: AppCoordinator.Path) -> some View {
        switch path {
        case .characters:
            charactersView
        case .characterLocation(let location):
            characterLocationView(location: location)
        }
    }
}

extension AppCoordinator {
    
    @MainActor @ViewBuilder var initialView: some View {
        RootView(viewModel: RootViewModel(coordinator: self))
    }
    
    @MainActor @ViewBuilder var charactersView: some View {
        CharactersView(viewModel: CharactersViewModel(coordinator: self))
    }
    
    @MainActor @ViewBuilder func characterLocationView(location: String) -> some View {
        CharacterLocationView(viewModel: CharacterLocationViewModel(coordinator: self, location: location))
    }
}

// MARK: - Navigations

extension AppCoordinator: AppNavigationCoordinator {
    
    func showCharacters() {
        navigationPath.append(Path.characters)
    }
    
    func showCharacterLocation(location: String) {
        navigationPath.append(Path.characterLocation(location))
    }
}

// MARK: - Instance

extension AppCoordinator {
    static var sample: AppCoordinator {
        .init()
    }
}
