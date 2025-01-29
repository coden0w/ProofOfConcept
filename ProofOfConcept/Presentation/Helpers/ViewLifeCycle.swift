//
//  ViewLifeCycle.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import Combine
import SwiftUI

protocol ViewLifeCycle {
    func onAppear()
    func onDisappear()
}

extension View {
    func bind(lifeCycle: ViewLifeCycle) -> some View {
        self.onAppear(perform: lifeCycle.onAppear)
            .onDisappear(perform: lifeCycle.onDisappear)
    }
}
