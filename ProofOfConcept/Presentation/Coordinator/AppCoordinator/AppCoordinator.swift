//
//  AppCoordinator.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import SwiftUI
import Combine

protocol AppNavigationCoordinator: BaseCoordinatorImpl {
    func showCharacters()
    func showCharacterLocation(location: String)
}

final class AppCoordinator: BaseCoordinatorImpl {
    
    // MARK: - Navigation Paths
    
    enum Path: Hashable {
        case characters
        case characterLocation(String)
    }
    
    // MARK: - Properties
    
    @Published var navigationPath = [AnyHashable]()
    
    override init() {
        super.init()
    }
    
    @ViewBuilder
    func buildPathDestionation(path: Path) -> some View {
        switch path {
        case .characters:
            charactersView
        case .characterLocation(let location):
            characterLocationView(location: location)
        }
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

// MARK: - ViewBuilders

extension AppCoordinator {
    
    @ViewBuilder var initialView: some View {
        RootView(viewModel: .init(coordinator: self))
    }
    
    @ViewBuilder var charactersView: some View {
        CharactersView(viewModel: .init(coordinator: self))
    }
    
    @ViewBuilder func characterLocationView(location: String) -> some View {
        CharacterLocationView(viewModel: .init(coordinator: self, location: location))
    }
}

// MARK: - Instance

extension AppCoordinator {
    static var sample: AppCoordinator {
        .init()
    }
}
