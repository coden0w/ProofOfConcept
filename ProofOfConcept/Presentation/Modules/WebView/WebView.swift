//
//  WebView.swift
//  ProofOfConcept
//
//  Created by David Martin Nevado on 17/2/25.
//

import SwiftUI
import WebKit
import WebViewSPM

struct WebView: View {
    @ObservedObject var viewModel: WebViewViewModel
    
    var body: some View {
        VStack {
            WebViewRespresentable()
        }
        .padding()
        .bind(lifeCycle: viewModel)
        .navigationTitle(Text("WebView"))
    }
}
