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
    func onAppear() async
    func onDisappear() async
}

extension View {
    func bind(lifeCycle: ViewLifeCycle) -> some View {
        self.onAppear { Task { await lifeCycle.onAppear() } }
        .onDisappear { Task { await lifeCycle.onDisappear() } }
    }
}
