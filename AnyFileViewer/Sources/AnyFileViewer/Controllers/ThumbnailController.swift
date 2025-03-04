//
//  ThumbnailController.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

import Foundation
import UIKit

public protocol ThumbnailController {
    @MainActor
    func generateThumbnail(for url: URL) async throws -> UIImage?
}

extension ThumbnailController {
    @MainActor
    func downloadFile(from item: AnyFileModel) async throws -> URL {
        guard let url = URL(string: item.url) else {
            fatalError("No URL found")
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let tempURL = FileManager.default
            .temporaryDirectory
            .appendingPathComponent("thumbnail-\(String((0..<9).compactMap { _ in "1234567890".randomElement() })).mp4")
        try data.write(to: tempURL)
        return tempURL
    }
}
