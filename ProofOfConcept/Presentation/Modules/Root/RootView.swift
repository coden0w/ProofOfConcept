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
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    ListItemView(item.title)
                        .onTapGesture {
                            viewModel.navigateTo(item.id)
                        }
                }
            }
            .listStyle(.plain)
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle("Go To")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension RootView {
    
    @ViewBuilder
    private func ListItemView(_ item: String) -> some View {
        HStack {
            Text(item)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    RootView(viewModel: .sample)
}

