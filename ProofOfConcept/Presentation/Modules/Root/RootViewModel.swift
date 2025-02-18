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
                                             .init(id: 1, title: "Characters"),
                                             .init(id: 2, title: "WebView")]
    init(coordinator: AppCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    override func onAppear() async {
        await super.onAppear()
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }

    func navigateToCharacters() {
        self.coordinator?.showCharacters()
    }

    func navigateTo(_ id: Int) {
        switch id {
        case .zero:
            self.coordinator?.showCharactersDownload()
        case 1:
            self.coordinator?.showCharacters()
        case 2:
            self.coordinator?.showWebView()
        default:
            break
        }
    }
}

extension RootViewModel {
    static var sample: RootViewModel {
        RootViewModel(coordinator: .sample)
    }
}
