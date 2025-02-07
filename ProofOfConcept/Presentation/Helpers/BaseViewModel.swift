//
//  BaseViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import SwiftUI
import Combine

/*
 @MainActor: Attribute to run code on the main thread essencial for the UI comunication and instatiation
 @preconcurrency: mark preexisting code which is not adapted to the new concurrency model like a todo for migration from Swift 5 > Swift 6
 
 */
@MainActor
class BaseViewModel<T>: ObservableObject, ViewLifeCycle {
    
    private var _coordinator: (AppCoordinatorProtocol)?
    public var subscriptions = [AnyCancellable]()
    
    public var coordinator: T? {
        _coordinator as? T
    }
    
    public init(coordinator: AppCoordinatorProtocol) {
        self._coordinator = coordinator
    }
    
    open func onAppear() async {
        print("View calls onAppear \(String(describing: Self.self))")
    }
    
    open func onDisappear() async {
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
