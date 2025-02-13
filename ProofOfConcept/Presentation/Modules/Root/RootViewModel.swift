//
//  RootViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

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
        self.coordinator?.showCharacters()
    }
}

extension RootViewModel {
    static var sample: RootViewModel {
        RootViewModel(coordinator: .sample)
    }
}
