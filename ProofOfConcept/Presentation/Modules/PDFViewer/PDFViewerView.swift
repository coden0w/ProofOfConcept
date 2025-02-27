//
// Created by Inditex on 19/2/25
//

import SwiftUI
import PDFKit
import PDFViewer

struct PDFViewerView: View {
    @ObservedObject var viewModel: PDFViewerViewModel

    @State private var showPicker: Bool = false
    @State private var showEditOptions: Bool = false
    @State private var pdfView = PDFView()
    
    @State private var isDrawModalShowing: Bool = false
    @State private var currentPath = Path()
    @State private var drawing = Drawing()

    var body: some View {
        TabView {
            remoteViewer
            localViewer
        }
        .bind(lifeCycle: viewModel)
        .navigationTitle(Text("PDF Viewer"))
    }
}

extension PDFViewerView {
    private var remoteViewer: some View {
        VStack {
            if let url = viewModel.selectedRemotePDF {
                ZStack {
                    PDFViewer(url: url)
                        .edgesIgnoringSafeArea(.all)
                        .padding(32)
                    
                    if isDrawModalShowing {
                        VStack {
                            Text("Try to draw over the document")
                            Image(systemName: "hand.draw")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(width: 300, height: 120)
                                .shadow(radius: 8)
                        }
                        .transition(.opacity)
                    }
                    
                    Canvas { context, size in
                        for path in drawing.paths {
                            context.stroke(path, with: .color(.black), lineWidth: 2)
                        }
                        context.stroke(currentPath, with: .color(.black), lineWidth: 2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let point = value.location
                                if currentPath.isEmpty {
                                    currentPath.move(to: point)
                                } else {
                                    currentPath.addLine(to: point)
                                }
                            }
                            .onEnded { _ in
                                drawing.paths.append(currentPath)
                                currentPath = Path()
                            }
                    )
                }
                .border(Color.gray, width: 1)
                
                HStack {
                    Button("Clear draw") {
                        drawing.clear()
                    }
                    .padding()
                    
                    Button("Save PDF") {
                        drawing.save(url, drawing: drawing)
                    }
                    .padding()
                }
                
                Spacer()
                
                Divider()

                Button("PDF Editor options", systemImage: "pencil") {
                    showEditOptions.toggle()
                }
                .sheet(isPresented: $showEditOptions) {
                    VStack {
                        Text("✏️ PDF Editor options")
                            .bold()
                            .font(.headline)
                        
                        Divider()

                        VStack(alignment: .leading) {
                            Text("Add annotation")
                                .bold()
                                .font(.headline)
                            HStack {
                                TextField(text: $viewModel.annotationText) {
                                    Text("Ex: Hello world!")
                                }
                                .padding()
                                .border(.gray, width: 1.0)
                                
                                Button {
                                    pdfView.document = PDFDocument(url: url)
                                    pdfView.addAnnotation(text: viewModel.annotationText)
                                    showEditOptions.toggle()
                                    showPicker.toggle()
                                } label: {
                                    Text("Execute")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            
                            Divider()
                            
                            Text("Hightlight text")
                                .bold()
                                .font(.headline)
                            HStack {
                                TextField(text: $viewModel.hightlightedText) {
                                    Text("Ex: Lorem ipsum")
                                }
                                .padding()
                                .border(.gray, width: 1.0)
                                
                                Button {
                                    pdfView.document = PDFDocument(url: url)
                                    pdfView.highlightText(searchText: viewModel.hightlightedText)
                                    showEditOptions.toggle()
                                    showPicker.toggle()
                                } label: {
                                    Text("Execute")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        .padding(16)
                        
                        Spacer()
                    }
                    .padding()
                    .modifier(EditOptionsModifier())
                }
                .padding()
            } else {
                ProgressView()
            }
        }
        .tabItem {
            Label("From remote", systemImage: "cloud")
        }
        .sheet(isPresented: $showPicker) {
            if let savedUrl = pdfView.savePDFToDocuments(fileName: "Test\(String((0..<9).compactMap { _ in "1234567890".randomElement() })).pdf") {
                PDFViewer(url: savedUrl)
            }
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    isDrawModalShowing.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    isDrawModalShowing.toggle()
                }
            }
        }
    }

    private var localViewer: some View {
        VStack {
            HStack {
                Button("Remove PDF") {
                    viewModel.selectedLocalPDF = nil
                }
                .disabled(viewModel.selectedLocalPDF == nil)

                Spacer()

                Button("Add PDF") {
                    showPicker.toggle()
                }
                .disabled(viewModel.selectedLocalPDF != nil)
            }
            .padding()
            
            Divider()
            Spacer()

            if let url = viewModel.selectedLocalPDF {
                PDFViewer(url: url)
            }
        }
        .sheet(isPresented: $showPicker) {
            PDFPickerViewer(pdfUrl: $viewModel.selectedLocalPDF)
        }
        .tabItem {
            Label("From local", systemImage: "folder")
        }
    }
}

struct Drawing {
    var paths: [Path] = []
    private var currentPath = Path()
    
    mutating func addPoint(_ point: CGPoint) {
        if currentPath.isEmpty {
            currentPath.move(to: point)
        } else {
            currentPath.addLine(to: point)
        }
    }
    
    mutating func endPath() {
        paths.append(currentPath)
        currentPath = Path()
    }
    
    mutating func clear() {
        paths.removeAll()
    }
    
    @MainActor
    mutating func save(_ url: URL, drawing: Drawing) {
        guard let pdfDocument = PDFDocument(url: url),
              let page = pdfDocument.page(at: 0) else { return }
        
        if let image = drawing.toImage(size: CGSize(width: 300, height: 150)) {
            let annotation = PDFAnnotation(
                bounds: CGRect(x: 100, y: 100, width: 300, height: 150),
                forType: .stamp,
                withProperties: nil
            )
            let imageBounds = CGRect(x: (annotation.startPoint.x * -1), y: (annotation.startPoint.y * -1), width: 100, height: 20)
            let imageStamp = PDFImageAnnotation(image: image, properties: nil, rect: imageBounds)
            page.removeAnnotation(annotation)
            imageStamp.fieldName = "CustomPDF"
            page.addAnnotation(imageStamp)
            
            if let data = pdfDocument.dataRepresentation() {
                let fileManager = FileManager.default
                let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                let newURL = documentsDirectory?.appendingPathComponent("Modified_PDF.pdf")

                do {
                    guard let newURL else { return }
                    try data.write(to: newURL)
                    print("PDF saved sucessfull: \(newURL.path())")
                } catch {
                    print("Error saving PDF: \(error)")
                }
            }
        }
    }
    
    func toImage(size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let cgContext = context.cgContext
            cgContext.setFillColor(UIColor.clear.cgColor)
            cgContext.fill(CGRect(origin: .zero, size: size))
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.setLineWidth(2)
            
            for path in paths {
                cgContext.addPath(path.toCGPath())
                cgContext.strokePath()
            }
        }
    }
}

extension Path {
    func toCGPath() -> CGPath {
        let path = UIBezierPath()
        self.forEach { element in
            switch element {
            case .move(to: let point):
                path.move(to: point)
            case .line(to: let point):
                path.addLine(to: point)
            case .quadCurve(to: let point, control: let control):
                path.addQuadCurve(to: point, controlPoint: control)
            case .curve(to: let point, control1: let control1, control2: let control2):
                path.addCurve(to: point, controlPoint1: control1, controlPoint2: control2)
            case .closeSubpath:
                path.close()
            }
        }
        return path.cgPath
    }
}

final private class PDFImageAnnotation: PDFAnnotation {
    var image: UIImage?

    convenience init(image: UIImage?, properties: [AnyHashable: Any]?, rect: CGRect) {
        self.init(bounds: rect, forType: .stamp, withProperties: properties)
        self.image = image
    }

    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        guard let cgImage = image?.cgImage else { return }
        context.draw(cgImage, in: self.bounds)
    }
}
