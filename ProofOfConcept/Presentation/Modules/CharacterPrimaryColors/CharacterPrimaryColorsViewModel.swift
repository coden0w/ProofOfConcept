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
    private var suscriptions = [AnyCancellable]()
    
    @Published var selectedImage: UIImage?
    @Published var isImagePickerPresented: Bool = false
    @Published var primaryColors = [PrimaryColorModel]()
    @Published var totalTime: String = ""
    @Published var showPermissionDeniedAlert: Bool = false
    
    // MARK: - Initializer
    
    init(coordinator: AppCoordinator) {
        super.init(coordinator: coordinator)
        self.setListeners()
    }
    
    // MARK: - Life Cycle
    
    override func onAppear() async {
        await super.onAppear()
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }
    
    // MARK: - Listeners
    
    private func setListeners() {
        $selectedImage.sink { image in
            if let image = image {
                Task {
                    let (totalTime, colors) = await self.imageService.getDominantColors(from: image)
                    self.totalTime = String(totalTime)
                    self.primaryColors = colors.map {
                        return .init(color: $0, hexColor: $0.toHex())
                    }
                }
            }
        }
        .store(in: &suscriptions)
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
