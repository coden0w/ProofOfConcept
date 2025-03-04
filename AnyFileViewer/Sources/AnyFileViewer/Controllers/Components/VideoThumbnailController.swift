//
//  VideoThumbnailController.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

import Foundation
import UIKit
import AVKit

public class VideoThumbnailController: ThumbnailController {
    public init() {}

    public func generateThumbnail(for url: URL) async throws -> UIImage? {
        do {
            let asset = AVURLAsset(url: url)
            let imageGen = AVAssetImageGenerator(asset: asset)
            let cgImage = try imageGen.copyCGImage(at: .zero, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            return nil
        }
    }
}
