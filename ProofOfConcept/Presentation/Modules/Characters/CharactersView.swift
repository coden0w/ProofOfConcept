//
//  CharactersView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 29/1/25.
//

import Foundation
import SwiftUI

struct CharactersView: View {
    
    @ObservedObject var viewModel: CharactersViewModel
    @State private var imagePreview: Image = .init("")
    @State private var isPresentedPreview: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                List(viewModel.characters) { item in
                    CharacterView(item)
                        .listRowSeparator(.hidden)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.details(item.id)
                        }
                }
                .listStyle(.plain)
                HStack {
                    if viewModel.page > Constants.one {
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
                    if viewModel.page < Constants.fourtyTwo {
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
            if isPresentedPreview {
                withAnimation(.smooth) {
                    PreviewImageView()
                }
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
    private func CharacterView(_ item: CharacterModel) -> some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: item.image)) { image in
                    image.resizable()
                        .frame(width: Constants.fifty,
                               height: Constants.fifty,
                               alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.ten))
                        .onTapGesture {
                            imagePreview = image
                            withAnimation(.smooth()) {
                                isPresentedPreview = true
                            }
                        }
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
                    
                    HStack(spacing: Constants.five) {
                        Text(item.status)
                            .font(.caption)
                        Circle()
                            .frame(width: Constants.eight,
                                   height: Constants.eight,
                                   alignment: .center)
                            .foregroundStyle(item.status == "Alive" ? .green : .red)
                        Spacer()
                    }
                }
                
                Image(systemName: "chevron.right")
            }
        }
    }
    
    private func PreviewImageView() -> some View {
        ZStack {
            Color.black.opacity(Constants.dotEight)
                .ignoresSafeArea()
            imagePreview
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
        }
        .onTapGesture {
            withAnimation(.smooth()) {
                isPresentedPreview = false
            }
        }
    }
    
    struct Constants {
        static let dotEight: CGFloat = 0.8
        static let one: Int = 1
        static let five: CGFloat = 5
        static let eight: CGFloat = 8
        static let ten: CGFloat = 10
        static let fourtyTwo: Int = 42
        static let fifty: CGFloat = 50
    }
}

#Preview {
    CharactersView(viewModel: .sample)
}
