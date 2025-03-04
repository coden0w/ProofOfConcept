//
//  ThumbnailFileView.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

import SwiftUI

public struct ThumbnailFileView: View {
    @State private var thumbnail: UIImage?
    
    private var model: AnyFileModel
    private let thumbnailController: ThumbnailController
    
    public init(model: AnyFileModel, thumbnailController: ThumbnailController) {
        self.model = model
        self.thumbnailController = thumbnailController
    }

    public var body: some View {
        Group {
            if let thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            } else {
                ProgressView()
                    .frame(width: 32, height: 32)
            }
        }
        .task {
            do {
                let tmpUrl = try await thumbnailController.downloadFile(from: model)
                thumbnail = try await thumbnailController.generateThumbnail(for: tmpUrl)
            } catch {}
        }
    }
}
