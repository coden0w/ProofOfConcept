//
//  RootViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import Combine

class RootViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Properties
    
    
    init(coordinator: AppCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    override func onAppear() async {
        await super.onAppear()
        navigateToCharacters()
    }
    
    override func onDisappear() async {
        await super.onDisappear()
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
