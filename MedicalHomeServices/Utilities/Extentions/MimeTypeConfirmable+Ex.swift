//
//  MimeTypeConfirmable.swift
//  MuafaClient
//
//  Created by Khaled on 11/02/2023.
//

import Foundation
import UniformTypeIdentifiers

protocol MimeTypeConfirmable {
    var mimeType: String { get }
    func contains(_ utType: UTType) -> Bool
}


extension MimeTypeConfirmable {
    var isImage: Bool {
        contains(.image)
    }
    
    var isMovie: Bool {
        contains(.movie)
    }
    
    var isAudio: Bool {
        contains(.audio)
    }
    
    var isPDF: Bool {
        contains(.pdf)
    }
    
    var isDocument: Bool {
        contains(.content)
    }
    
    var isSpreadsheet: Bool {
        contains(.spreadsheet)
    }
    
    var isPresentation: Bool {
        contains(.presentation)
    }
    
    var isArchive: Bool {
        contains(.archive)
    }
    
    func contains(_ utType: UTType) -> Bool {
        UTType(mimeType: mimeType)?.conforms(to: utType) ?? false
    }
    
    //}
    //
    //
    //extension AttachmentModel: MimeTypeConfirmable {
    //    var mimeType: String {
    //        UTType(mimeType: contentType ?? "")?.preferredMIMEType ?? "application/octet-stream"
    //    }
    //}
    
    
//    extension URL: MimeTypeConfirmable {
//        var mimeType: String {
//            UTType(filenameExtension: pathExtension)?.preferredMIMEType ?? "application/octet-stream"
//        }
//    }
    
    
    // MARK: - FileListItem
    //
    //enum FileListItem: Identifiable {
    //    case localFile(URL)
    //    case attachment(AttachmentModel)
    //
    //    var id: String {
    //        switch self {
    //        case .localFile(let uRL):
    //            return uRL.absoluteString
    //        case .attachment(let attachment):
    //            return attachment.refId ?? ""
    //        }
    //    }
    //}
    //
    //extension FileListItem: Equatable {
    //    static func == (lhs: FileListItem, rhs: FileListItem) -> Bool {
    //        lhs.id == rhs.id
    //    }
    //}
    //
    //extension FileListItem: MimeTypeConfirmable {
    //    var mimeType: String {
    //        switch self {
    //        case .localFile(let uRL):
    //            return uRL.mimeType
    //        case .attachment(let attachment):
    //            return attachment.mimeType
    //        }
    //    }
    //
    //    var url: URL? {
    //        switch self {
    //        case .localFile(let uRL):
    //            return uRL
    //        case .attachment(let attachment):
    //            return URL(string: attachment.downloadURL ?? "")
    //        }
    //    }
    //
    //    var name: String {
    //        switch self {
    //        case .localFile(let uRL):
    //            return uRL.lastPathComponent
    //        case .attachment(let attachment):
    //            return attachment.name ?? ""
    //        }
    //    }
    //}
    
    //import SwiftUI
    //extension FileListItem {
    //    var image: ImageSource {
    //        if isImage, let url {
    //            return .url(url, placeholder: Image("png_ico"))
    //
    //        } else if isMovie, let url = url {
    //            // iconView.kf.setImage(
    //            //     with: AVAssetImageDataProvider(assetURL: url, seconds: 1),
    //            //     placeholder: UIImage(named: "mov_ico")
    //            // )
    //            return .url(url, placeholder: Image("mov_ico"))
    //
    //        } else if isAudio {
    //            return .asset("file_ico") // TODO: Add Audio Image
    //
    //        } else if isPDF {
    //            return .asset("pdf_ico")
    //
    //        } else if isSpreadsheet {
    //            return .asset("xls_ico")
    //
    //        } else if isPresentation {
    //            return .asset("ppt_ico")
    //
    //        } else if isDocument {
    //            return .asset("doc_ico")
    //
    //        } else if isArchive {
    //            return .asset("zip_ico")
    //
    //        } else /*if url.contains(.item)*/ {
    //            return .asset("file_ico")
    //
    //        }
    //
    //    }
    //
    //}
    
    
    //extension Array where Element == FileListItem {
    //    var localFiles: [URL] {
    //        compactMap { item in
    //            if case .localFile(let uRL) = item {
    //                return uRL
    //            }
    //            return nil
    //        }
    //    }
    //
    //    // func replaceLocalFiles(newValue localFiles: [URL]) {
    //    //     removeAll
    //    // }
    //}
    //
    //extension Array where Element == URL {
    //    var fileList: [FileListItem] {
    //        map { FileListItem.localFile($0) }
    //    }
    //}
}
