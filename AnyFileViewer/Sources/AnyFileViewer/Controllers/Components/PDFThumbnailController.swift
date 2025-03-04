//
//  PDFThumbnailController.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

import Foundation
import UIKit
import QuickLook

public class PDFThumbnailController: ThumbnailController {
    public init() {}

    public func generateThumbnail(for url: URL) async throws -> UIImage? {
        guard let document = PDFDocument(url: url),
              let page = document.page(at: 0) else {
            return nil
        }
        let thumbnailSize = CGSize(width: 32, height: 32)
        let renderer = UIGraphicsImageRenderer(size: thumbnailSize)
        
        var image: UIImage = UIImage()
        var thumbnail = renderer.image { ctx in
            let pdfPageSize = page.bounds(for: .mediaBox)
            let renderer = UIGraphicsImageRenderer(size: pdfPageSize.size)
            image = renderer.image { ctx in
                UIColor.white.set()
                ctx.fill(pdfPageSize)
                ctx.cgContext.translateBy(x: 0.0, y: pdfPageSize.size.height)
                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                page.draw(with: .mediaBox, to: ctx.cgContext)
            }
        }
        thumbnail = image
        return thumbnail
    }
}
