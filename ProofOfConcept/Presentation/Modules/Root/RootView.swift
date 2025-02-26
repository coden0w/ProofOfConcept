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
        .onAppear {
            checkDeferredDeepLink()
        }
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

extension RootView {
    private func checkDeferredDeepLink() {
        if let deferredLink = UserDefaults.standard.string(forKey: "deferredDeepLink") {
            print("Deferred deeplink detected: \(deferredLink)")

            UserDefaults.standard.removeObject(forKey: "deferredDeepLink")
        }
    }
}

#Preview {
    RootView(viewModel: .sample)
}

