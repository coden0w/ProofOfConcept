//
//  TxtThumbnailController.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

import Foundation
import UIKit

public class TxtThumbnailController: ThumbnailController {
    public init() {}

    public func generateThumbnail(for url: URL) async throws -> UIImage? {
        await MainActor.run {
            guard let text = try? String(contentsOf: url).prefix(100) else { return nil }
            
            let size = CGSize(width: 32, height: 32)
            let label = UILabel()
            label.text = String(text)
            label.font = UIFont.systemFont(ofSize: 8)
            label.textColor = .black
            label.backgroundColor = .white
            label.numberOfLines = 5
            label.frame = CGRect(origin: .zero, size: size)
            
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            label.drawHierarchy(in: label.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image
        }
    }
}
