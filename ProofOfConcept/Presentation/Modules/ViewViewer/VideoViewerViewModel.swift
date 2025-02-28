//
// Created by Inditex on 28/2/25
//

import Foundation
import SwiftUI
import VideosViewer

class VideoViewerViewModel: BaseViewModel<AppCoordinatorProtocol> {
    @Published var urlVideo: URL?
    
    private let urlVideos: [URL?] = [URL(string: "https://videos.pexels.com/video-files/2915101/2915101-sd_640_360_25fps.mp4"),
                                    URL(string: "https://videos.pexels.com/video-files/2330708/2330708-sd_640_360_24fps.mp4"),
                                    URL(string: "https://videos.pexels.com/video-files/3335969/3335969-sd_640_360_30fps.mp4"),
                                    URL(string: "https://videos.pexels.com/video-files/856896/856896-sd_640_360_30fps.mp4"),
                                    URL(string: "https://videos.pexels.com/video-files/3152730/3152730-sd_640_360_30fps.mp4"),
                                    URL(string: "https://videos.pexels.com/video-files/1840201/1840201-sd_640_360_25fps.mp4")]

    override func onAppear() async {
        await super.onAppear()
        self.urlVideo = urlVideos.randomElement() ?? URL(string: "")!
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }
}
