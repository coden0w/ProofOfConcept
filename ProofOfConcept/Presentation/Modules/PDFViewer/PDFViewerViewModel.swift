//
// Created by Inditex on 19/2/25
//

import Foundation
import SwiftUI

class PDFViewerViewModel: BaseViewModel<AppCoordinatorProtocol> {
    @Published var selectedRemotePDF: URL?
    @Published var selectedLocalPDF: URL?

    override func onAppear() async {
        await super.onAppear()
        self.selectedRemotePDF = URL(string: "https://pdfobject.com/pdf/sample.pdf")
    }
    
    override func onDisappear() async {
        await super.onDisappear()
    }
}
