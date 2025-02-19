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
        pdfView.backgroundColor = .clear
        pdfView.layer.backgroundColor = UIColor.white.cgColor
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

public extension PDFView {
    @MainActor
    func addAnnotation(text: String) {
        guard let document = self.document,
              let page = document.page(at: 0) else { return }

        let annotation = PDFAnnotation(
            bounds: CGRect(x: 50, y: 0, width: 100, height: 50),
            forType: .freeText,
            withProperties: nil
        )
        annotation.contents = text
        annotation.font = UIFont.systemFont(ofSize: 18)
        annotation.fontColor = .red
        page.addAnnotation(annotation)
    }
    
    func highlightText(searchText: String) {
        guard let document = self.document else { return }

        let selections = document.findString(searchText, withOptions: .caseInsensitive)

        for selection in selections {
            if let page = selection.pages.first {
                let highlight = PDFAnnotation(bounds: selection.bounds(for: page),
                                              forType: .highlight,
                                              withProperties: nil)
                highlight.color = UIColor.yellow.withAlphaComponent(0.5)
                page.addAnnotation(highlight)
            }
        }
    }
    
    func savePDFToDocuments(fileName: String) -> URL? {
        guard let document else { return nil }

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if document.write(to: fileURL) {
            print("PDF saved successfully at: \(fileURL)")
            return fileURL
        } else {
            print("Error saving PDF")
            return nil
        }
    }
}
