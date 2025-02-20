//
//  EditOptionsModifier.swift
//  PDFViewer
//
//  Created by David Martin Nevado on 19/2/25.
//

import SwiftUI

public struct EditOptionsModifier: ViewModifier {
    public init() {}

    public func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content
                .presentationDetents([.medium])
                .presentationCornerRadius(8)
                .presentationDragIndicator(.automatic)
        } else {
            content
        }
    }
}
