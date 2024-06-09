import Foundation
import SwiftUI
import UIKit

struct DocumentPicker: UIViewControllerRepresentable {

    let onDocumentPicked: ([URL]) -> Void

    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(onDocumentPicked: onDocumentPicked)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .compositeContent, .image, .video, .content, .audio])
        picker.allowsMultipleSelection = true
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {

        private let onDocumentPicked: ([URL]) -> Void

        init(onDocumentPicked: @escaping ([URL]) -> Void){
            self.onDocumentPicked = onDocumentPicked
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)
            // This line to get access to the file
            // url.startAccessingSecurityScopedResource()
            let result = urls.filter { $0.startAccessingSecurityScopedResource() }
            onDocumentPicked(result)
        }
    }
}
