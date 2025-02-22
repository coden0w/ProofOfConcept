//
// Created by Inditex on 21/2/25
//

import SwiftUI
import PDFKit
import PDFViewer
import AnyFileViewer

struct AnyFileViewerView: View {
    @ObservedObject var viewModel: AnyFileViewerViewModel

    @State private var isPresent: Bool = false
    
    private let listItems: [AnyFileType] = AnyFileType.allCases

    var body: some View {
        VStack {
            List(listItems, id:\.self) { item in
                Button("Open \(item.file.ext.uppercased()) file to preview") {
                    Task {
                        await viewModel.openFile(type: item)
                        isPresent.toggle()
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
}
