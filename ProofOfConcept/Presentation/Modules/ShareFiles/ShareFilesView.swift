//
// Created by Inditex on 24/2/25
//

import SwiftUI
import UniformTypeIdentifiers
import ShareFiles

struct ShareFilesView: View {
    @ObservedObject var viewModel: ShareFilesViewModel

    @State private var selectedFileURL: URL?
    @State private var isDocumentPickerPresented = false
    @State private var isSharingPresented = false

    var body: some View {
        VStack(spacing: 20) {
            if let fileURL = selectedFileURL {
                Text("Selected file: \(fileURL.lastPathComponent)")
                    .padding()
            }

            Button("Select file to sharing") {
                isDocumentPickerPresented = true
            }
            .buttonStyle(.borderedProminent)
        }
        .fileImporter(isPresented: $isDocumentPickerPresented,
                      allowedContentTypes: [UTType.data],
                      allowsMultipleSelection: false) { result in
            do {
                if let selectedURL = try result.get().first {
                    selectedFileURL = selectedURL
                    isSharingPresented.toggle()
                }
            } catch {
                print("Error al seleccionar el archivo: \(error.localizedDescription)")
            }
        }
        .sheet(isPresented: $isSharingPresented) {
            if let fileURL = selectedFileURL {
                ShareFiles(activityItems: [fileURL])
            }
        }
    }
}
