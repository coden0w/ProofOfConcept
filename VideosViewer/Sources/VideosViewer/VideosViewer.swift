// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AVKit

public struct VideoPlayerView: View {
    @State private var player = AVPlayer()
    
    private var url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden()
            .onAppear {
                guard let url else { return }
                player = AVPlayer(url: url)
                player.play()
            }
            .onDisappear {
                player.pause()
            }
    }
}
