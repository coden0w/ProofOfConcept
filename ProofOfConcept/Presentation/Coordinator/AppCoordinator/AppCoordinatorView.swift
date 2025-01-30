//
//  AppCoordinatorView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import SwiftUI

struct AppCoordinatorView: View {
    
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            coordinator.initialView
                .navigationDestination(for: AnyHashable.self) { hashable in
                    if let path = hashable as? AppCoordinator.Path {
                        coordinator.buildPathDestionation(path: path)
                    } else {
                        Text("")
                            .onAppear {
                                assertionFailure("❌ Unexpected navigation destination received!")
                            }
                    }
                }
        }
    }
}

#Preview {
    AppCoordinatorView(coordinator: .sample)
}
