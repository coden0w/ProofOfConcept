//
//  ImageService.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 15/2/25.
//

import Foundation
import SwiftUI
import Accelerate

protocol ImageService: Sendable {
    func downloadImage(from urlString: String) async -> UIImage?
    func getDominantColors(from image: UIImage, maxColors: Int) async -> (CFAbsoluteTime, [UIColor])
}

actor DefaultImageService: ImageService {
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func getDominantColors(from image: UIImage, maxColors: Int = 4) -> (CFAbsoluteTime, [UIColor]) {
        // add switch to enable/disable background remove.
        let startTime = CFAbsoluteTimeGetCurrent()
        
        guard let resizedImage = image.resized(to: CGSize(width: 100, height: 100)),
              let resizedCGImage = resizedImage.cgImage else { return (.zero, []) }
        
        var format = vImage_CGImageFormat(
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            colorSpace: nil,
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            version: 0,
            decode: nil,
            renderingIntent: .defaultIntent
        )
        
        var sourceBuffer = vImage_Buffer()
        defer { free(sourceBuffer.data) }
        
        guard vImageBuffer_InitWithCGImage(&sourceBuffer,
                                           &format,
                                           nil,
                                           resizedCGImage,
                                           vImage_Flags(kvImageNoFlags)) == kvImageNoError else { return (.zero, []) }
        

        let pixelData = UnsafeBufferPointer(
            start: sourceBuffer.data.assumingMemoryBound(to: UInt8.self),
            count: Int(sourceBuffer.height * sourceBuffer.width * 4)
        )
        
        var pixels = [(CGFloat, CGFloat, CGFloat)]()
        for i in stride(from: 0, to: pixelData.count, by: 4) {
            let alpha = pixelData[i]
            let r = CGFloat(pixelData[i + 1]) / 255.0
            let g = CGFloat(pixelData[i + 2]) / 255.0
            let b = CGFloat(pixelData[i + 3]) / 255.0

            if alpha > 200 {
                pixels.append((r, g, b))
            }
        }
        
        let dominantColors = kMeansCluster(pixels, k: maxColors)
        
        let totalTime = CFAbsoluteTimeGetCurrent() - startTime
        return (totalTime, dominantColors)
    }
    
    // MARK: - K-Means Clustering para colores
    func kMeansCluster(_ pixels: [(CGFloat, CGFloat, CGFloat)], k: Int) -> [UIColor] {
        guard !pixels.isEmpty else { return [] }
        
        var centroids = pixels.shuffled().prefix(k)
        
        for _ in 0..<10 {
            var clusters: [[(CGFloat, CGFloat, CGFloat)]] = Array(repeating: [], count: k)
            
            for pixel in pixels {
                let distances = centroids.map { distance($0, pixel) }
                if let closest = distances.enumerated().min(by: { $0.element < $1.element })?.offset {
                    clusters[closest].append(pixel)
                }
            }
            
            for i in 0..<k {
                if !clusters[i].isEmpty {
                    let mean = averageColor(clusters[i])
                    centroids[i] = mean
                }
            }
        }
        
        return centroids.map { UIColor(red: $0.0, green: $0.1, blue: $0.2, alpha: 1.0) }
    }
    
    func distance(_ c1: (CGFloat, CGFloat, CGFloat), _ c2: (CGFloat, CGFloat, CGFloat)) -> CGFloat {
        let (r1, g1, b1) = c1
        let (r2, g2, b2) = c2
        return sqrt(pow(r1 - r2, 2) + pow(g1 - g2, 2) + pow(b1 - b2, 2))
    }
    
    func averageColor(_ colors: [(CGFloat, CGFloat, CGFloat)]) -> (CGFloat, CGFloat, CGFloat) {
        let total = CGFloat(colors.count)
        let sum = colors.reduce((0.0, 0.0, 0.0)) { (acc, color) in
            return (acc.0 + color.0, acc.1 + color.1, acc.2 + color.2)
        }
        return (sum.0 / total, sum.1 / total, sum.2 / total)
    }
}

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: targetSize, format: format).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

extension UIColor {
    func toHex() -> String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "#XXXXXX"
        }
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
