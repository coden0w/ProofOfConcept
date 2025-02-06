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
    
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        ZStack {
            VStack {
                List(viewModel.characters) { item in
                    CharacterView(item)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            viewModel.details(item.id)
                        }
                }
                .listStyle(.plain)
                HStack {
                    if viewModel.page > 1 {
                        Button {
                            viewModel.previewPage()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    } else {
                        Spacer()
                    }
                    Spacer()
                    Text(viewModel.page.description)
                        .font(.title2)
                    Spacer()
                    if viewModel.page < 42 {
                        Button {
                            viewModel.nextPage()
                        } label: {
                            Text("Next")
                            Image(systemName: "chevron.right")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
                .padding(.horizontal)
            }
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
                    
                    HStackLayout(spacing: 5) {
                        Text(item.status)
                            .font(.caption)
                        Circle()
                            .frame(width: 8, height: 8, alignment: .center)
                            .foregroundStyle(item.status == "Alive" ? .green : .red)
                        Spacer()
                    }
                }
                
                Image(systemName: "chevron.right")
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
