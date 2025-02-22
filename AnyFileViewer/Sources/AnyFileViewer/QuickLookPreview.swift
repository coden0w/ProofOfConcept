//
//  DocumentViewModel.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 20/2/25.
//

import SwiftUI
import QuickLook

public class QuickLookPreviewItem: NSObject, QLPreviewItem {
    public var previewItemURL: URL?
    public var previewItemTitle: String?
    
    public init(url: URL, title: String) {
        self.previewItemURL = url
        self.previewItemTitle = title
    }
}

public struct QuickLookPreview: UIViewControllerRepresentable {
    var item: QuickLookPreviewItem
    
    public init(item: QuickLookPreviewItem) {
        self.item = item
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        let qlPreviewController = QLPreviewController()
        qlPreviewController.dataSource = context.coordinator
        let uiNavigationController = UINavigationController(rootViewController: qlPreviewController)
        return uiNavigationController
    }

    public func updateUIViewController(_: UIViewController, context _: Context) { }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: QLPreviewControllerDataSource {
        let parent: QuickLookPreview

        public init(parent: QuickLookPreview) {
            self.parent = parent
        }

        public func numberOfPreviewItems(in what: QLPreviewController) -> Int {
            1
        }

        public func previewController(_: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            parent.item
        }
    }
}
