//
// Created by Inditex on 19/2/25
//

import SwiftUI
import PDFKit
import PDFViewer

struct PDFViewerView: View {
    @ObservedObject var viewModel: PDFViewerViewModel

    @State private var showPicker: Bool = false
    @State private var showEditOptions: Bool = false
    @State private var pdfView = PDFView()

    var body: some View {
        TabView {
            remoteViewer
            localViewer
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle(Text("PDF Viewer"))
    }
}

extension PDFViewerView {
    private var remoteViewer: some View {
        VStack {
            if let url = viewModel.selectedRemotePDF {
                PDFViewer(url: url)
                    .edgesIgnoringSafeArea(.all)
                    .padding(32)
                
                Spacer()
                
                Divider()

                Button("PDF Editor options", systemImage: "pencil") {
                    showEditOptions.toggle()
                }
                .sheet(isPresented: $showEditOptions) {
                    VStack {
                        Text("✏️ PDF Editor options")
                            .bold()
                            .font(.headline)
                        
                        Divider()

                        VStack(alignment: .leading) {
                            Text("Add annotation")
                                .bold()
                                .font(.headline)
                            HStack {
                                TextField(text: $viewModel.annotationText) {
                                    Text("Ex: Hello world!")
                                }
                                .padding()
                                .border(.gray, width: 1.0)
                                
                                Button {
                                    pdfView.document = PDFDocument(url: url)
                                    pdfView.addAnnotation(text: viewModel.annotationText)
                                    showEditOptions.toggle()
                                    showPicker.toggle()
                                } label: {
                                    Text("Execute")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            
                            Divider()
                            
                            Text("Hightlight text")
                                .bold()
                                .font(.headline)
                            HStack {
                                TextField(text: $viewModel.hightlightedText) {
                                    Text("Ex: Lorem ipsum")
                                }
                                .padding()
                                .border(.gray, width: 1.0)
                                
                                Button {
                                    pdfView.document = PDFDocument(url: url)
                                    pdfView.highlightText(searchText: viewModel.hightlightedText)
                                    showEditOptions.toggle()
                                    showPicker.toggle()
                                } label: {
                                    Text("Execute")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        .padding(16)
                        
                        Spacer()
                    }
                    .padding()
                    .modifier(EditOptionsModifier())
                }
                .padding()
            } else {
                ProgressView()
            }
        }
        .tabItem {
            Label("From remote", systemImage: "cloud")
        }
        .sheet(isPresented: $showPicker) {
            if let savedUrl = pdfView.savePDFToDocuments(fileName: "Test\(String((0..<9).compactMap { _ in "1234567890".randomElement() })).pdf") {
                PDFViewer(url: savedUrl)
            }
        }
    }

    private var localViewer: some View {
        VStack {
            HStack {
                Button("Remove PDF") {
                    viewModel.selectedLocalPDF = nil
                }
                .disabled(viewModel.selectedLocalPDF == nil)

                Spacer()

                Button("Add PDF") {
                    showPicker.toggle()
                }
                .disabled(viewModel.selectedLocalPDF != nil)
            }
            .padding()
            
            Divider()
            Spacer()

            if let url = viewModel.selectedLocalPDF {
                PDFViewer(url: url)
            }
        }
        .sheet(isPresented: $showPicker) {
            PDFPickerViewer(pdfUrl: $viewModel.selectedLocalPDF)
        }
        .tabItem {
            Label("From local", systemImage: "folder")
        }
    }
}
