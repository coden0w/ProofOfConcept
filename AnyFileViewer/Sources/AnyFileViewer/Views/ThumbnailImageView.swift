//
//  ThumbnailImageView.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

import SwiftUI

public struct ThumbnailImageView: View {
    private var model: AnyFileModel
    
    public init(model: AnyFileModel) {
        self.model = model
    }

    public var body: some View {
        if let url = URL(string: model.url) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                ProgressView()
                    .frame(width: 32, height: 32)
            }
        }
    }
}
