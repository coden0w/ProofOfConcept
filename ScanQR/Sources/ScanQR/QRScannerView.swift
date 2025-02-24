//
//  QRScannerView.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 24/2/25.
//

import SwiftUI
import AVFoundation

public struct QRScannerView: UIViewControllerRepresentable {
    @Binding var result: String

    public init(result: Binding<String>) {
        self._result = result
    }

    public func makeUIViewController(context: Context) -> QRScannerController {
        let controller = QRScannerController()
        controller.delegate = context.coordinator

        return controller
    }

    public func updateUIViewController(_ uiViewController: QRScannerController, context: Context) {
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator($result)
    }
    
    public class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        @Binding public var scanResult: String

        public init(_ scanResult: Binding<String>) {
            self._scanResult = scanResult
        }

        public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if metadataObjects.count == 0 {
                scanResult = ""
                return
            }

            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

            if metadataObj.type == AVMetadataObject.ObjectType.qr,
               let result = metadataObj.stringValue {
                scanResult = result
            } else {
                scanResult = ""
            }
        }
    }
}

public class QRScannerController: UIViewController {
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?

    var delegate: AVCaptureMetadataOutputObjectsDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()

        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }

        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            print(error)
            return
        }

        captureSession.addInput(videoInput)

        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)

        captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [ .qr ]

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)

        DispatchQueue.global(qos: .background).async {
            Task { @MainActor in
                self.captureSession.startRunning()
            }
        }
    }
}
