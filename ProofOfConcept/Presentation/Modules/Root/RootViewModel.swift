//
//  RootViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation

class RootViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Properties
    @Published var items: [ListItemModel] = [.init(id: 0, title: "Characters Download"),
                                             .init(id: 1, title: "Characters")]
    
    init(coordinator: AppCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    override func onAppear() async {
        await super.onAppear()
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }
    
    func navigateTo(_ id: Int) {
        if id == .zero {
            self.coordinator?.showCharactersDownload()
        } else {
            self.coordinator?.showCharacters()
        }
    }
}

extension RootViewModel {
    static var sample: RootViewModel {
        RootViewModel(coordinator: .sample)
    }
}
