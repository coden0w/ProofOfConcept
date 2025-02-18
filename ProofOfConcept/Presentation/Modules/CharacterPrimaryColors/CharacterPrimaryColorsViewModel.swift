//
//  CharacterPrimaryColorsViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 15/2/25.
//

import Foundation
import Combine
import SwiftUI

final class CharacterPrimaryColorsViewModel: BaseViewModel<AppCoordinatorProtocol> {
    
    // MARK: - Properties
    private let photoLibraryService = DefaultPhotoLibraryService()
    private let imageService = DefaultImageService()
    
    @Published var selectedImage: UIImage? {
        didSet { extractPrimaryColors() }
    }
    
    @Published var isImagePickerPresented: Bool = false
    @Published var primaryColors = [PrimaryColorModel]()
    @Published var totalTime: String = ""
    @Published var showPermissionDeniedAlert: Bool = false
    
    // MARK: - Initializer
    
    init(coordinator: AppCoordinator) {
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() async {
        await super.onAppear()
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }
    
    // MARK: - Listeners
    
    private func extractPrimaryColors() {
        Task {
            guard let selectedImage else { return }
            let (totalTime, colors) = await self.imageService.getDominantColors(from: selectedImage)
            self.totalTime = String(totalTime)
            self.primaryColors = colors.map { .init(color: $0, hexColor: $0.toHex()) }
        }
    }
    
    // MARK: - Functions
    
    func pickPhoto() {
        Task {
            if await self.photoLibraryService.requestPermission() {
                self.isImagePickerPresented = true
            } else {
                self.showPermissionDeniedAlert = true
            }
        }
    }
    
    func removePhoto() {
        selectedImage = nil
    }
    
    // MARK: - Private Functions
    
}

extension CharacterPrimaryColorsViewModel {
    static var sample: CharacterPrimaryColorsViewModel {
        return CharacterPrimaryColorsViewModel(coordinator: .sample)
    }
}
