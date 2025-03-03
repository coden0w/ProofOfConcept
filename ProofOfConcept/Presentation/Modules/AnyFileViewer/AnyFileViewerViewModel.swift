//
// Created by Inditex on 21/2/25
//

import Foundation
import SwiftUI
import AnyFileViewer

class AnyFileViewerViewModel: BaseViewModel<AppCoordinatorProtocol> {
    @Published var item: QuickLookPreviewItem?

    override func onAppear() async {
        await super.onAppear()
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }
    
    func openFile(type: AnyFileType) async {
        await self.downloadFile(type: type)
    }

    private func downloadFile(type: AnyFileType) async {
        do {
            guard let url = URL(string: type.file.url) else { return }

            let (tempURL, _) = try await URLSession.shared.download(for: URLRequest(url: url))

            let fileManager = FileManager.default
            let destinationURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("document.\(type.file.ext)")

            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }

            try fileManager.moveItem(at: tempURL, to: destinationURL)
            
            DispatchQueue.main.async {
                self.item = QuickLookPreviewItem(url: destinationURL, title: "\(type.file.ext.uppercased()) preview")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AnyFileModel {
    let url: String
    let ext: String
}

enum AnyFileType: String, CaseIterable, Hashable {
    case pdf
    case img
    case xls
    case doc
    case zip
    case mp4
    case txt

    var file: AnyFileModel {
        switch self {
        case .pdf:
            return AnyFileModel(url: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf", ext: "pdf")
        case .img:
            return AnyFileModel(url: "https://fujifilm-x.b-cdn.net/wp-content/uploads/2021/01/gfx100s_sample_04_oulq-min.jpg", ext: "jpg")
        case .xls:
            return AnyFileModel(url: "https://www.cmu.edu/blackboard/files/evaluate/tests-example.xls", ext: "xls")
        case .doc:
            return AnyFileModel(url: "https://podcasts.ceu.edu/sites/podcasts.ceu.edu/files/sample.doc", ext: "doc")
        case .zip:
            return AnyFileModel(url: "https://getsamplefiles.com/download/zip/sample-1.zip", ext: "zip")
        case .mp4:
            return AnyFileModel(url: "https://file-examples.com/wp-content/storage/2017/04/file_example_MP4_480_1_5MG.mp4", ext: "mp4")
        case .txt:
            return AnyFileModel(url: "https://example-files.online-convert.com/document/txt/example.txt", ext: "txt")
        }
    }
}
