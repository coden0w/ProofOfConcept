//
//  RootViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import Combine

class RootViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    override func onAppear() {
        super.onAppear()
    }
    
    override func onDisappear() {
        super.onDisappear()
    }
    
    func navigateToCharacters() {
        coordinator.showCharacters()
    }
}

extension RootViewModel {
    static var sample: RootViewModel {
        return RootViewModel(coordinator: .sample)
    }
}
