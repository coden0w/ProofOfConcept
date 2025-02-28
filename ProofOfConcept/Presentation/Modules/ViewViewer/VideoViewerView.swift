//
// Created by Inditex on 28/2/25
//

import SwiftUI
import VideosViewer

struct VideoViewerView: View {
    @ObservedObject var viewModel: VideoViewerViewModel
    
    @State private var uuid: UUID?

    var body: some View {
        TabView {
            VideoPlayerView(url: viewModel.urlVideo)
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle(Text("Video Viewer"))
        .onChange(of: viewModel.urlVideo) { _ in
            uuid = UUID()
        }
        .id(uuid)
    }
}
