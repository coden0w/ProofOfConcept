//
//  AppCoordinator.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import SwiftUI
import Combine

// MARK: - ScreenPath

enum ScreenPath: Hashable {
    case characters
    case characterDetail(CharacterModel)
}

extension ScreenPath {
    var identifier: String {
        let desc = String(describing: self)
        if let index = desc.firstIndex(of: "(") {
            return String(desc[..<index])
        } else {
            return desc
        }
    }
}

// MARK: - AppNavigationCoordinator

protocol AppCoordinatorProtocol {
    func showCharacters()
    func showCharacterDetail(_ character: CharacterModel)
    func pop()
    func popToRoot()
    func popToScreen(_ screen: ScreenPath)
}

// MARK: - AppCoordinator

@Observable
final class AppCoordinator: Identifiable {
    
    // MARK: - Properties
    
    var navigationPath = [AnyHashable]()
    private var subscriptions = [AnyCancellable]()
    
    init() {
        // Empty
    }
}

// MARK: - Navigations

extension AppCoordinator: AppCoordinatorProtocol {
    
    func showCharacters() {
        navigationPath.append(ScreenPath.characters)
    }
    
    func showCharacterDetail(_ character: CharacterModel) {
        navigationPath.append(ScreenPath.characterDetail(character))
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
    
    func popToScreen(_ screen: ScreenPath) {
        if let index = navigationPath.firstIndex(where: { anyHashable in
            if let path = anyHashable.base as? ScreenPath {
                return path.identifier == screen.identifier
            } else {
                return false
            }
        }) {
            let removeLastItem = navigationPath.count - index - 1
            navigationPath.removeLast(removeLastItem)
        } else {
            print("💩 Could not pop to screen \(screen.identifier)")
        }
    }
}

// MARK: - Instance

extension AppCoordinator {
    static var sample: AppCoordinator {
        .init()
    }
}
