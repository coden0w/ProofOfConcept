//
//  ProofOfConceptApp.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import SwiftUI

@main
struct ProofOfConceptApp: App {
    
    @State var coordinator = AppCoordinator.sample
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: coordinator)
        }
    }
}
