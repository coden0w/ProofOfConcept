//
//  CharactersDownloadView.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 14/2/25.
//

import Foundation
import SwiftUI

struct CharactersDownloadView: View {
    
    @ObservedObject var viewModel: CharactersDownloadViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Download characters photos and create album")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Divider()
                CustomTextFieldView(title: "Fill the album name",
                                    placeholder: "i.e. Rick & Morty",
                                    bindingText: $viewModel.albumName)
                HStack(alignment: .bottom, spacing: 20) {
                    CustomTextFieldView(title: "Select page from 0 to 42",
                                        placeholder: "i.e. 15",
                                        bindingText: $viewModel.page)
                    
                    
                    CustomButton()
                }
                
                ProgressBarView()
                
                Spacer()
            }
            .padding()
            .showError(viewModel)
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle("Characters Download")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension CharactersDownloadView {
    
    private func CustomTextFieldView(title: String,
                                     placeholder: String,
                                     bindingText: Binding<String>) -> some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.callout)
                    .foregroundStyle(.primary)
                TextField(placeholder, text: bindingText)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .tint(.green)
            }
        }
    }
    
    private func CustomButton() -> some View {
        ZStack {
            Button {
                viewModel.download()
            } label: {
                Text(viewModel.isDownloading ? "Downloading..." : "Download")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.green)
                    )
                
            }
        }
    }
    
    private func ProgressBarView() -> some View {
        ZStack {
            ProgressView(value: viewModel.progress,
                         total: Double(viewModel.imageCount)) {
                if viewModel.progress > .zero, viewModel.progress < 4 {
                    Text("Downloading...")
                }
            } currentValueLabel: {
                Text("Downloaded \(Int(viewModel.progress).description) of \(viewModel.imageCount) images")
            }
            .tint(.green)
        }
    }
}

extension View {
    func showError(_ viewModel: CharactersDownloadViewModel) -> some View {
        self.alert(isPresented: .constant(viewModel.showError != .none)) {
            switch viewModel.showError {
            case .albumName:
                return Alert(title: Text("No album name filled"),
                             message: Text("Is mandatory to put an album name to download photos and create the album"),
                             dismissButton: .default(Text("Close"), action: {}))
            case .permissions:
                return Alert(title: Text("Permission denied"),
                             message: Text("Is mandatory to grant access gallery to download photos and create the album"),
                             dismissButton: .default(Text("Close"), action: {}))
            case .service:
                return Alert(title: Text("Service Error"),
                             message: Text("Service has failed"),
                             dismissButton: .default(Text("Close"), action: {}))
            case .none:
                return Alert(title: Text(""))
            }
        }
    }
}

#Preview {
    CharactersDownloadView(viewModel: .sample)
}
