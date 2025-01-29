//
//  BaseViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import SwiftUI
import Combine

class BaseViewModel: ObservableObject, ViewLifeCycle {
    
    open func onAppear() {
        print("onAppear \(String(describing: Self.self))")
    }
    
    open func onDisappear() {
        print("onDisappear \(String(describing: Self.self))")
    }
}

extension View {
    func bind(viewModel: BaseViewModel) -> some View {
        self.bind(lifeCycle: viewModel)
    }
}
