//
// Created by Inditex on 24/2/25
//

import SwiftUI
import ScanQR
import WebKit

struct ScanQRView: View {
    @ObservedObject var viewModel: ScanQRViewModel
    
    @State var scanResult = ""
    
    @State private var showWebView: Bool = false

    var body: some View {
        VStack {
            Text(scanResult)
                .bold()
            Divider()
            QRScannerView(result: $scanResult)
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle(Text("Scan QR"))
        .toolbar {
            if !scanResult.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showWebView.toggle()
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                    }
                }
            }
        }
        .sheet(isPresented: $showWebView) {
            VStack {
                Text("QR website")
                    .bold()
                Divider()
                OpenQRWebView(urlString: scanResult)
            }
            .padding()
            .presentationDetents([.large])
            .presentationCornerRadius(8)
            .presentationDragIndicator(.visible)
        }
    }
}

struct OpenQRWebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        } else {
            print("No URL found")
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}
