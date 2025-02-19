// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import PDFKit
import UniformTypeIdentifiers

public struct PDFViewer: UIViewRepresentable {
    private var url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    public func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: url)
    }
}

public struct PDFPickerViewer: UIViewControllerRepresentable {
    @Binding var pdfUrl: URL?

    public init(pdfUrl: Binding<URL?>) {
        self._pdfUrl = pdfUrl
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    public class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: PDFPickerViewer

        public init(_ parent: PDFPickerViewer) {
            self.parent = parent
        }

        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.pdfUrl = urls.first
        }
    }
}
