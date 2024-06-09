//
// Data+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation

extension Data {
    func fileURL(fileName: String) throws -> URL {
        
        let directoryURLs = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let directoryURL = directoryURLs[0]

        let url = directoryURL.appendingPathComponent(fileName)

        // Try to load from cashes
        if FileManager.default.fileExists(atPath: url.path(percentEncoded: false)) {
            return url
        }
        
        // Create Intermediate Directories
        let pathURL = url.deletingLastPathComponent().path(percentEncoded: false)
      
        if !FileManager.default.fileExists(atPath: pathURL) {
            try FileManager.default.createDirectory(
                atPath: pathURL,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        
        // Save to file
        try write(to: url, options: .withoutOverwriting)
        
        return url
        
    }

}
