//
//  BaseViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class BaseViewModel<T>: ObservableObject, @preconcurrency ViewLifeCycle {
    
    private var _coordinator: (AppCoordinatorProtocol)?
    public var subscriptions = [AnyCancellable]()
    
    public var coordinator: T? {
        _coordinator as? T
    }
    
    public init(coordinator: AppCoordinatorProtocol) {
        self._coordinator = coordinator
    }
    
    open func onAppear() {
        print("View calls onAppear \(String(describing: Self.self))")
    }
    
    open func onDisappear() {
        print("View calls onDisappear \(String(describing: Self.self))")
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
