//
//  AppCoordinator.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

protocol AppCoordinatorProtocol {
    func showCharacters()
    func showCharacterDetail(_ character: CharacterModel)
    func showCharactersDownload()
    func showWebView()
}

@MainActor
final class AppCoordinator: ObservableObject, Identifiable {
    @Published var rootNavigation = NavigationItem<RootViewModel>()
    @Published var charactersNavigation = NavigationItem<CharactersViewModel>()
    @Published var characterDetailNavigation = NavigationItem<CharacterDetailViewModel>()
    @Published var charactersDownloadNavigation = NavigationItem<CharactersDownloadViewModel>()
    @Published var webViewNavigation = NavigationItem<WebViewViewModel>()
}

extension AppCoordinator: @preconcurrency AppCoordinatorProtocol {
    func showRoot() {
        let viewModel = RootViewModel(coordinator: self)
        rootNavigation.navigate(to: viewModel)
    }
    
    func showCharacters() {
        let viewModel = CharactersViewModel(coordinator: self)
        charactersNavigation.navigate(to: viewModel) {
            print("Characters screen dismissed")
        }
    }
    
    func showCharacterDetail(_ character: CharacterModel) {
        let viewModel = CharacterDetailViewModel(coordinator: self, character: character)
        characterDetailNavigation.navigate(to: viewModel) {
            print("Character detail screen dismissed")
        }
    }

    func showCharactersDownload() {
        let viewModel = CharactersDownloadViewModel(coordinator: self)
        charactersDownloadNavigation.navigate(to: viewModel)
    }
    
    func showWebView() {
        let viewModel = WebViewViewModel(coordinator: self)
        webViewNavigation.navigate(to: viewModel)
    }
}

extension AppCoordinator {
    static var sample: AppCoordinator {
        AppCoordinator()
    }
}

struct NavigationItem<Object> {
    var onDismissAction: (() -> ())?
    var viewModel: Object?
    var isActive: Bool = false {
        didSet {
            if !isActive {
                viewModel = nil
                onDismissAction?()
                onDismissAction = nil
            }
        }
    }
    
    init(viewModel: Object? = nil,
         isActive: Bool = false,
         onDismissAction: (() -> ())? = nil) {
        print("init: viewModel: \(String(describing: viewModel.self))")
        print("init: isActive: \(String(describing: isActive))")
        self.viewModel = viewModel
        self.isActive = isActive
        self.onDismissAction = nil
    }
    
    mutating func navigate(to viewModel: Object,
                           onDismissAction: (() -> ())? = nil) {
        print("navigate: viewModel: \(String(describing: viewModel.self))")
        isActive = true
        self.viewModel = viewModel
        self.onDismissAction = onDismissAction
    }
    
    mutating func dismiss() {
        isActive = false
    }
}
