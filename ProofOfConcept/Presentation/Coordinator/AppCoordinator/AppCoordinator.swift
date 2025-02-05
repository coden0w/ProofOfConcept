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
    func pop()
    func popToRoot()
    func popToScreen(_ screen: AppCoordinator.Path)
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
}

// MARK: - Navigations

extension AppCoordinator: AppNavigationCoordinator {
    
    func showCharacters() {
        navigationPath.append(Path.characters)
    }
    
    func showCharacterLocation(location: String) {
        navigationPath.append(Path.characterLocation(location))
    }
    
    func popToRoot() {
        navigationPath.removeAll()
    }
    
    func pop() {
        guard navigationPath.count > 1 else {
            return
        }
        navigationPath.removeLast()
    }
    
    func popToScreen(_ screen: AppCoordinator.Path) {
        if let index = navigationPath.firstIndex(where: { $0 == screen as AnyHashable }) {
            let removeLastItems = navigationPath.count - index - 1
            navigationPath.removeLast(removeLastItems)
        } else {
            print("y una mierda")
        }
        
    }
}

// MARK: - Instance

extension AppCoordinator {
    static var sample: AppCoordinator {
        .init()
    }
}
