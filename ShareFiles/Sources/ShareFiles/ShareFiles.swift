//
//  ShareFiles.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 24/2/25.
//

import SwiftUI

public struct ShareFiles: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    public init(activityItems: [Any]) {
        self.activityItems = activityItems
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.airDrop] // Fill forbidden types
        return activityViewController
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
