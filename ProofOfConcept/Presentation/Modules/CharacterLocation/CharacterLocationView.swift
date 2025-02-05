//
//  CharacterLocationView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 30/1/25.
//

import Foundation
import SwiftUI
import Combine

struct CharacterLocationView: View {
    
    @ObservedObject var viewModel: CharacterLocationViewModel
    
    var body: some View {
        ZStack {
            CharacterLocationView(viewModel.characterLocationModel)
        }
        .bind(viewModel: viewModel)
    }
}

extension CharacterLocationView {
    
    func CharacterLocationView(_ model: CharacterLocationModel) -> some View {
        ZStack {
            VStack {
                Button {
                    viewModel.popToRoot()
                } label: {
                    Text("Volver a root")
                }
                Spacer()
                VStack {
                    Text("Name: \(model.name)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Type: \(model.type)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Dimension: \(model.dimension)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                .fixedSize(horizontal: true, vertical: false)
                Spacer()
            }
        }
    }
    
    struct Constants {
        static let ten: CGFloat = 10
        static let fifty: CGFloat = 50
    }

}

#Preview {
    CharacterLocationView(viewModel: .sample)
}
