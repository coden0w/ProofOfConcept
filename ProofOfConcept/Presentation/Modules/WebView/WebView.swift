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
    let webView: WKWebView

    init() {
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        let webView = WKWebView(frame: .zero, configuration: config)
        self.webView = webView
        
        let coordinator = WebViewCoordinator(parent: self)
        WebViewCoordinator.ReceiveAPIHandlers.allCases.forEach {
            contentController.add(coordinator, name: $0.rawValue)
        }
        WebViewCoordinator.SendAPIHandlers.allCases.forEach {
            contentController.addScriptMessageHandler(coordinator, contentWorld: .page, name: $0.rawValue)
        }
    }

    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

@MainActor
class WebViewCoordinator: NSObject {
    var parent: WebViewRespresentable

    init(parent: WebViewRespresentable) {
        self.parent = parent
    }
    
    enum ReceiveAPIHandlers: String, CaseIterable {
        case getMessage
    }
    
    enum SendAPIHandlers: String, CaseIterable {
        case sendMessage
    }
}

extension WebViewCoordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let handler = ReceiveAPIHandlers(rawValue: message.name) else { return }
        switch handler {
        case .getMessage:
            getMessage(message)
        }
    }
}

extension WebViewCoordinator: WKScriptMessageHandlerWithReply {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) async -> (Any?, String?) {
        guard let handler = SendAPIHandlers(rawValue: message.name) else { return (nil, nil) }
        switch handler {
        case .sendMessage:
            let message = self.sendMessage()
            return (message, nil)
        }
    }
}

extension WebViewCoordinator {
    @objc func getMessage(_ message: WKScriptMessage) {
        guard let messageBody = message.body as? String else { return }
        print("Message received from JS: \(messageBody)")

        let responseMessage = "Received message: \(messageBody)"
        let jsCode = "receiveMessageFromSwift('\(responseMessage)')"
        parent.webView.evaluateJavaScript(jsCode, completionHandler: nil)
    }
    
    @objc func sendMessage() -> String {
        "My message from iOS to WebKit"
    }
}
