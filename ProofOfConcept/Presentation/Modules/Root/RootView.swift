//
//  RootView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        ZStack {
            Text("Splash")
        }
        .bind(lifeCycle: viewModel)
    }
}

#Preview {
    RootView(viewModel: .sample)
}

