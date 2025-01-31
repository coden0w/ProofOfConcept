//
//  BaseViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import SwiftUI
import Combine

class BaseViewModel<T>: ObservableObject, ViewLifeCycle {
    
    private var _coordinator: AppNavigationCoordinator?
    
    public var coordinator: T? {
        _coordinator as? T
    }
    
    public init(coordinator: AppNavigationCoordinator) {
        self._coordinator = coordinator
    }
    
    open func onAppear() {
        print("onAppear \(String(describing: Self.self))")
    }
    
    open func onDisappear() {
        print("onDisappear \(String(describing: Self.self))")
    }
    
    deinit {
        print("deinit \(String(describing: Self.self))")
    }
}

extension View {
    func bind<T>(viewModel: BaseViewModel<T>) -> some View {
        self.bind(lifeCycle: viewModel)
    }
}
