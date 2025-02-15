//
//  CharactersDownloadViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 14/2/25.
//

import Foundation
import Combine

enum ErrorAlertType {
    case albumName
    case permissions
    case service
    case none
}

class CharactersDownloadViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Properties
    
    private let photoLibraryService = DefaultPhotoLibraryService()
    private let imageService = DefaultImageService()
    
    @Published var albumName: String = ""
    @Published var isDownloading: Bool = false
    @Published var progress: Double = .zero
    @Published var imageCount: Int = 1000
    @Published var page: String = ""
    @Published var showError: ErrorAlertType = .none
    
    // MARK: - Dependencies
    
    private let getAllCharactersUseCase: GetAllCharactersUseCase
    
    // MARK: - Initializers
    
    init(coordinator: AppCoordinator,
         getAllCharactersUseCase: GetAllCharactersUseCase = Dependency.shared.getAllCharactersUseCase) {
        self.getAllCharactersUseCase = getAllCharactersUseCase
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() async {
        await super.onAppear()
        checkPermissions()
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }
    
    // MARK: - Functions
    
    func download() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                do {
                    guard let page = Int(self.page) else { return }
                    let response: CharactersDomainModel = try await self.getAllCharactersUseCase.execute(CharactersRequestDomainModel(page: page))
                    self.imageCount = response.characters.count
                    guard let album = try await self.photoLibraryService.fetchOrCreateAlbum(named: self.albumName) else { return }
                    response.characters.forEach { character in
                        group.addTask {
                            guard let image = await self.imageService.downloadImage(from: character.image) else { return }
                            do {
                                try await self.photoLibraryService.saveImage(image, to: album)
                                await MainActor.run {
                                    self.progress += 1.0
                                }
                            } catch {
                                await MainActor.run {
                                    self.showError = .albumName
                                }
                            }
                        }
                    }
                } catch {
                    await MainActor.run {
                        self.showError = .service
                    }
                }
            }
            
            await MainActor.run {
                self.isDownloading = false
                self.progress = .zero
            }
        }
    }
    
    // MARK: - Private Functions
    
    private func checkPermissions() {
        Task {
            let isGranted = await self.photoLibraryService.requestPermission()
            self.showError = isGranted ? .none : .permissions
        }
    }
    
}

extension CharactersDownloadViewModel {
    static var sample: CharactersDownloadViewModel {
        return CharactersDownloadViewModel(coordinator: .sample)
    }
}
