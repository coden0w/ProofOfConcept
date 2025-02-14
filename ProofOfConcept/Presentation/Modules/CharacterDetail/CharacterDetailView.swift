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
                LocationView(viewModel.origin)
                LocationView(viewModel.location)
                EpisodeView(viewModel.episode)
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
                .overlay {
                    BackgroundGradientView()
                }
                .mask(Text(model.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center))
            HStack {
                Circle()
                    .frame(width: Constants.ten,
                           height: Constants.ten,
                           alignment: .center)
                    .foregroundStyle(model.status == "Alive" ? .green : .red)
                    .shadow(color: model.status == "Alive" ? .green : .red, radius: Constants.ten)
                Text(String(format: "%@ - %@", model.status, model.species))
                    .font(.callout)
                    .fontWeight(.semibold)
                
            }
        }
    }
    
    private func LocationView(_ model: LocationModel) -> some View {
        ZStack {
            BackgroundGradientView()
            HStack {
                VStack(alignment: .leading) {
                    Text(model.isOrigin ? "Origin" : "Location")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    AttributesView(["Name: \(model.name)",
                                    "Type: \(model.type)",
                                    "Dimension: \(model.dimension)",
                                    "Residents: \(model.residents)"])
                }
                .padding(.leading)
                Spacer()
            }
        }.padding(.horizontal)
    }
    
    private func EpisodeView(_ model: EpisodeModel) -> some View {
        ZStack {
            BackgroundGradientView()
            HStack {
                VStack(alignment: .leading) {
                    Text("Episode")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    AttributesView(["Name: \(model.name)",
                                    "Air date: \(model.airDate)",
                                    "Episode: \(model.episode)"])

                }
                .padding(.leading)
                Spacer()
            }
        }.padding(.horizontal)
    }
    
    private func AttributesView(_ items: [String]) -> some View {
        VStack(alignment: .leading) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.caption)
            }
        }
    }
    
    private func BackgroundGradientView() -> some View {
        RoundedRectangle(cornerRadius: Constants.twentyFour)
            .fill(LinearGradient(
                gradient: Gradient(colors: [.green, .green, .green, .yellow, .green]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .shadow(radius: Constants.five)
    }
    
    struct Constants {
        static let five: CGFloat = 5
        static let ten: CGFloat = 10
        static let twentyFour: CGFloat = 24
        static let thirty: CGFloat = 30
        static let hundredFifty: CGFloat = 150
    }
}

#Preview {
    CharacterDetailView(viewModel: .sample)
}
