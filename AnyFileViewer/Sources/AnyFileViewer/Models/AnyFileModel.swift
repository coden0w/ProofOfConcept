//
//  AnyFileModel.swift
//  AnyFileViewer
//
//  Created by David Martin Nevado on 4/3/25.
//

public struct AnyFileModel {
    public let url: String
    public let ext: FileExtensionType
    
    public init(url: String, ext: FileExtensionType) {
        self.url = url
        self.ext = ext
    }
}

public enum FileExtensionType: String {
    case pdf
    case img
    case xls
    case doc
    case zip
    case mp4
    case txt
}
