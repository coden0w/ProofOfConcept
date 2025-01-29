//
//  RootView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink("Characters") {
                        CharactersView(viewModel: .init())
                            .navigationTitle("Characters")
                    }
                }
                .listStyle(.sidebar)
                
            }
            .navigationTitle("ProofOfConcept")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RootView()
}
