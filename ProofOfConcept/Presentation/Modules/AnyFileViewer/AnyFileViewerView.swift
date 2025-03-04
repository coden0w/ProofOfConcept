//
// Created by Inditex on 21/2/25
//

import SwiftUI
import PDFKit
import PDFViewer
import AnyFileViewer
import AVFoundation
import QuickLook

struct AnyFileViewerView: View {
    @ObservedObject var viewModel: AnyFileViewerViewModel

    @State private var isPresent: Bool = false
    
    private let listItems: [AnyFileType] = AnyFileType.allCases

    var body: some View {
        VStack {
            List(listItems, id:\.self) { item in
                Button {
                    Task {
                        await viewModel.openFile(type: item)
                        isPresent.toggle()
                    }
                } label: {
                    HStack {
                        ThumnailView(item: item)
                        Text("Open \(item.file.ext.rawValue.uppercased()) file to preview")
                    }
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .sheet(isPresented: Binding(get: {
            isPresent && viewModel.item != nil
        }, set: { newValue in
            isPresent = newValue
        }), onDismiss: {
            viewModel.item = nil
        }) {
            if let item = viewModel.item {
                QuickLookPreview(item: item)
            }
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle(Text("Any file Viewer"))
    }

    struct ThumnailView: View {
        var item: AnyFileType

        var body: some View {
            switch item {
            case .pdf:
                HStack {
                    ThumbnailFileView(model: item.file, thumbnailController: PDFThumbnailController())
                    Divider()
                }
            case .img:
                HStack {
                    ThumbnailImageView(model: item.file)
                    Divider()
                }
            case .mp4:
                HStack {
                    ThumbnailFileView(model: item.file, thumbnailController: VideoThumbnailController())
                    Divider()
                }
            case .txt:
                HStack {
                    ThumbnailFileView(model: item.file, thumbnailController: TxtThumbnailController())
                    Divider()
                }
            default:
                EmptyView()
            }
        }
    }
}
