//
//  WebView.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 17/2/25.
//

import SwiftUI
import WebKit

struct WebView: View {
    @ObservedObject var viewModel: WebViewViewModel
    
    var body: some View {
        VStack {
            WebViewRespresentable()
        }
        .padding()
        .bind(lifeCycle: viewModel)
    }
}

struct WebViewRespresentable: UIViewRepresentable {
    class Coordinator: NSObject, WKScriptMessageHandler {
        var parent: WebViewRespresentable

        init(parent: WebViewRespresentable) {
            self.parent = parent
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "iosListener", let messageBody = message.body as? String {
                print("Mensaje recibido desde JS: \(messageBody)")

                let responseMessage = "SwiftUI recibió: \(messageBody)"
                let jsCode = "receiveMessageFromSwift('\(responseMessage)')"
                parent.webView.evaluateJavaScript(jsCode, completionHandler: nil)
            }
        }
    }

    let webView: WKWebView

    init() {
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        let webView = WKWebView(frame: .zero, configuration: config)
        self.webView = webView
        
        let coordinator = Coordinator(parent: self)
        contentController.add(coordinator, name: "iosListener")
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
