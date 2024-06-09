//
// UIImage+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation
import UIKit

extension UIImage {
    func saveToTemporaryDirectory() -> URL? {
        // Create a unique file name
        let uniqueFileName = ProcessInfo.processInfo.globallyUniqueString
        // Append a temporary directory URL
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = temporaryDirectoryURL.appendingPathComponent("\(uniqueFileName).jpg")

        // Convert UIImage to JPEG representation
        guard let data = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }

        // Write the data to the file
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image to temporary directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    func data() -> Data? {
        // Resize the image to 200px with a custom extension
        let resizedImage = self.aspectFittedToHeight(600)

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.7)

        return data
    }

    func aspectFittedToHeight(_ height: CGFloat) -> UIImage {
        let newHeight = min(height, self.size.height)
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
