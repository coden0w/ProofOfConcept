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
        NavigationView {
            ZStack {
                if let rootVM = coordinator.rootNavigation.viewModel {
                    RootView(viewModel: rootVM)
                        .navigation(isActive: $coordinator.charactersNavigation.isActive,
                                    destination: { getCharactersView() })
                        .navigation(isActive: $coordinator.charactersDownloadNavigation.isActive,
                                    destination: { getCharactersDownloadView() })
                        .navigation(isActive: $coordinator.webViewNavigation.isActive,
                                    destination: { getWebView() }) 
                }
            }
        }
    }
}

// MARK: - Views

extension AppCoordinatorView {
    
    func getCharactersView() -> some View {
        guard let vm = coordinator.charactersNavigation.viewModel else {
            fatalError("Characters view model not set.")
        }
        return CharactersView(viewModel: vm)
            .navigation(isActive: $coordinator.characterDetailNavigation.isActive) {
                getCharacterDetailView()
            }
    }
    
    func getCharacterDetailView() -> some View {
        guard let vm = coordinator.characterDetailNavigation.viewModel else {
            fatalError("Character detail view model not set.")
        }
        return CharacterDetailView(viewModel: vm)
    }

    func getCharactersDownloadView() -> some View {
        guard let vm = coordinator.charactersDownloadNavigation.viewModel else {
            fatalError("Characters download view model not set.")
        }
        return CharactersDownloadView(viewModel: vm)
    }
    
    func getWebView() -> some View {
        guard let vm = coordinator.webViewNavigation.viewModel else {
            fatalError("Characters download view model not set.")
        }
        return WebView(viewModel: vm)
    }
}

// MARK: - Extensions

extension View {
    func navigation<Destination: View>(isActive: Binding<Bool>,
                                       @ViewBuilder destination: () -> Destination) -> some View {
        overlay(
            VStack(spacing: .zero) {
                NavigationLink(
                    destination: isActive.wrappedValue ? destination() : nil,
                    isActive: isActive,
                    label: { EmptyView() }
                )
                // Solve a bug https://www.hackingwithswift.com/forums/swiftui/pop-multiple-nested-views-using-navigationview-and-isactive/13747
                .isDetailLink(false)
                // Workaround https://forums.swift.org/t/14-5-beta3-navigationlink-unexpected-pop/45279/21
                NavigationLink(destination: EmptyView(), label: {})
            }
        )
    }
}
