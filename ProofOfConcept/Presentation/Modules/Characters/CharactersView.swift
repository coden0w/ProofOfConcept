//
//  CharactersView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import SwiftUI
import Combine

struct CharactersView: View {
    
    @State var viewModel: CharactersViewModel
    
    var body: some View {
        ZStack {
            List(viewModel.characters) { item in
                CharacterView(item)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        viewModel.navigateToCharacterLocation(location: item.location)
                    }
            }
            .listStyle(.plain)
        }
        .bind(viewModel: viewModel)
        .navigationBarBackButtonHidden()
        .navigationTitle("Characters")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Extension

extension CharactersView {
    
    @ViewBuilder
    private func CharacterView(_ item: CharactersModel) -> some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: item.image)) { image in
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
                
                VStack {
                    Text(item.name)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(item.status)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
    
    struct Constants {
        static let ten: CGFloat = 10
        static let fifty: CGFloat = 50
    }
}

#Preview {
    CharactersView(viewModel: .sample)
}
