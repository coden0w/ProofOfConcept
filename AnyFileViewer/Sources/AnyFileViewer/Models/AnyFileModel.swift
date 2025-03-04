//
//  AnyFileModel.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

public struct AnyFileModel {
    public let url: String
    public let ext: String
    
    public init(url: String, ext: String) {
        self.url = url
        self.ext = ext
    }
}
