//
//  BaseViewModel.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import SwiftUI

/*
 @MainActor: Attribute to run code on the main thread essencial for the UI comunication and instatiation
 
 */

@MainActor
class BaseViewModel<T>: ObservableObject, ViewLifeCycle {
    private var _coordinator: (AppCoordinatorProtocol)?
    
    var coordinator: T? {
        _coordinator as? T
    }
    
    init(coordinator: AppCoordinatorProtocol) {
        self._coordinator = coordinator
    }
    
    func onAppear() async {
        print("View calls onAppear \(String(describing: Self.self))")
    }
    
    func onDisappear() async {
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
