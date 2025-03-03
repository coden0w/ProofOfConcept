// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AVKit
import Combine

public struct VideoPlayerView: View {
    @StateObject private var controller: VideoPlayerController

    public init(url: URL) {
        _controller = StateObject(wrappedValue: VideoPlayerController(url: url))
    }
    
    public var body: some View {
        VideoPlayer(player: controller.player)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden()
            .onAppear {
                controller.player.replaceCurrentItem(with: AVPlayerItem(url: controller.url))
            }
            .onDisappear {
                controller.pause()
            }
            .onChange(of: controller.mustStartPlaying) { isPlaying in
                if isPlaying {
                    controller.play()
                } else {
                    controller.pause()
                }
            }
    }
}

@MainActor
class VideoPlayerController: ObservableObject {
    @Published var player: AVPlayer
    var url: URL
    
    private var cancellables = Set<AnyCancellable>()

    @Published var mustStartPlaying: Bool = false

    init(url: URL) {
        self.url = url
        self.player = AVPlayer(url: url)
        setupObservers()
    }

    private func setupObservers() {
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                guard let self else { return }
                Task { @MainActor in
                    self.mustStartPlaying = status != .playing
                }
            }
            .store(in: &cancellables)
    }

    func play() {
        player.play()
    }

    func pause() {
        player.pause()
    }
}
