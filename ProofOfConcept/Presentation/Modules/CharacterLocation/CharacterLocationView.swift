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
            HStack {
                /*
                Spacer()
                AsyncImage(url: URL(string: model.image)) { image in
                    image.resizable()
                        .frame(width: Constants.fifty,
                               height: Constants.fifty,
                               alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.ten))
                } placeholder: {
                    ProgressView()
                        .frame(width: Constants.fifty,
                               height: Constants.fifty,
                               alignment: .center)
                }
                .padding(.trailing)
                 */
                VStack {
                    Text("Name: \(model.name)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Type: \(model.type)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Dimension: \(model.dimension)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
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
