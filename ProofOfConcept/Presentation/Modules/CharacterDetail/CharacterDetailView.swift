//
//  CharacterDetailView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 6/2/25.
//

import Foundation
import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewModel: CharacterDetailViewModel
    var body: some View {
        ZStack {
            VStack(spacing: Constants.thirty) {
                ProfileView(viewModel.character)
                InfoView(viewModel.character)
                Spacer()
            }
            .padding(.vertical)
        }
        .bind(viewModel: viewModel)
        .navigationTitle(viewModel.character.name)
    }
}

// MARK: - Extension

extension CharacterDetailView {
    
    private func ProfileView(_ model: CharacterModel) -> some View {
        AsyncImage(url: URL(string: model.image)) { image in
            image.resizable()
                .frame(width: Constants.hundredFifty,
                       height: Constants.hundredFifty,
                       alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: Constants.ten))
                .shadow(radius: Constants.ten)
        } placeholder: {
            ProgressView()
                .frame(width: Constants.hundredFifty,
                       height: Constants.hundredFifty,
                       alignment: .center)
                .tint(.green)
        }
    }
    
    private func InfoView(_ model: CharacterModel) -> some View {
        VStack {
            Text(model.name)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            HStack {
                Circle()
                    .frame(width: Constants.ten,
                           height: Constants.ten,
                           alignment: .center)
                    .foregroundStyle(model.status == "Alive" ? .green : .red)
                Text(String(format: "%@ - %@", model.status, model.species))
                    .font(.callout)
                
            }
        }
    }
    struct Constants {
        static let ten: CGFloat = 10
        static let thirty: CGFloat = 30
        static let hundredFifty: CGFloat = 150
    }
}

#Preview {
    CharacterDetailView(viewModel: .sample)
}
