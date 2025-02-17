//
//  CharacterPrimaryColorsView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 15/2/25.
//

import Foundation
import SwiftUI

struct CharacterPrimaryColorsView: View {
    
    @ObservedObject var viewModel: CharacterPrimaryColorsViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                ImagePreview()
            }
            .sheet(isPresented: $viewModel.isImagePickerPresented) {
                ImagePicker(image: $viewModel.selectedImage)
            }
            .showError(viewModel)
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle(Text("Primary Colors"))
    }
}

extension CharacterPrimaryColorsView {
    
    private func HeaderView() -> some View {
        ZStack {
            HStack {
                Button {
                    viewModel.removePhoto()
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.thirty,
                               alignment: .center)
                        .tint(.red)
                        
                }
                Spacer()
                Button {
                    viewModel.pickPhoto()
                } label: {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.fourty,
                               alignment: .center)
                        
                }
            }
            .padding(.horizontal, Constants.twenty)
        }
    }
    
    private func ImagePreview() -> some View {
        VStack(spacing: Constants.fifty) {
            Image(uiImage: viewModel.selectedImage ?? .init())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: Constants.twentyFour))
                .padding()
                
           
            PrimaryColorView(viewModel.primaryColors)
            Text("Processing total time: \(viewModel.totalTime)")
                .font(.caption)
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private func PrimaryColorView(_ models: [PrimaryColorModel]) -> some View {
        ZStack {
            HStack(spacing: Constants.fifty) {
                ForEach(models) { model in
                    VStack {
                        Rectangle()
                            .clipShape(Circle())
                            .foregroundStyle(Color(model.color))
                            .frame(width: Constants.fifty,
                                   height: Constants.fifty,
                                   alignment: .center)
                            .background(
                                Circle()
                                    .stroke(Color.gray,
                                            lineWidth: Constants.one)
                            )
                            .shadow(radius: Constants.five)
                        Text(model.hexColor)
                    }
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    struct Constants {
        static let one: CGFloat = 1
        static let five: CGFloat = 5
        static let twenty: CGFloat = 20
        static let twentyFour: CGFloat = 24
        static let thirty: CGFloat = 30
        static let fourty: CGFloat = 40
        static let fifty: CGFloat = 50
    }
}

fileprivate extension View {
    func showError(_ viewModel: CharacterPrimaryColorsViewModel) -> some View {
        self.alert(isPresented: .constant(viewModel.showPermissionDeniedAlert)) {
            Alert(title: Text("Permission denied"),
                         message: Text("Is mandatory to grant access gallery to choose photo and extract primary colors."),
                         dismissButton: .default(Text("Close"),
                                                 action: { viewModel.showPermissionDeniedAlert.toggle() }))
        }
    }
}

#Preview {
    CharacterPrimaryColorsView(viewModel: .sample)
}
