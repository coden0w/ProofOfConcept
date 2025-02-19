//
// Created by Inditex on 19/2/25
//

import SwiftUI
import PDFViewer

struct PDFViewerView: View {
    @ObservedObject var viewModel: PDFViewerViewModel
    
    @State private var showPicker: Bool = false

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
            } else {
                ProgressView()
            }
        }
        .tabItem {
            Label("From remote", systemImage: "cloud")
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
