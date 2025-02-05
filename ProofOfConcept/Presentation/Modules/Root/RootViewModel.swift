//
//  RootViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import Combine

class RootViewModel: BaseViewModel<AppNavigationCoordinator> {
    
    // MARK: - Properties
    
    
    init(coordinator: AppCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    override func onAppear() {
        super.onAppear()
        navigateToCharacters()
    }
    
    override func onDisappear() {
        super.onDisappear()
    }
    
    func navigateToCharacters() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coordinator?.showCharacters()
        }
    }
}

extension RootViewModel {
    static var sample: RootViewModel {
        return RootViewModel(coordinator: .sample)
    }
}
