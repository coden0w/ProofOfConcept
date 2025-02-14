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
            VStack {
                Text("Splash")
                Button {
                    viewModel.coordinator?.showCharacters()
                } label: {
                    Text("Go to Characters")
                }

            }
        }
        .bind(lifeCycle: viewModel)
    }
}

#Preview {
    RootView(viewModel: .sample)
}

