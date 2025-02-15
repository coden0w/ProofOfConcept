//
//  ImageService.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 15/2/25.
//

import Foundation
import SwiftUI

protocol ImageService: Sendable {
    func downloadImage(from urlString: String) async -> UIImage?
}

actor DefaultImageService: ImageService {
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
