//
//  ProofOfConceptApp.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import SwiftUI

@main
struct ProofOfConceptApp: App {
    
    @StateObject var coordinator = AppCoordinator.sample
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: coordinator)
                .onAppear {
                    coordinator.showRoot()
                }
        }
    }
}
