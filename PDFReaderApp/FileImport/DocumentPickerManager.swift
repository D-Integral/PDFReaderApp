//
//  DocumentPickerDelegate.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 31/12/2023.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

final class DocumentPickerManager: NSObject, UIDocumentPickerDelegate {
    let documentImportManager: DocumentImportManagerProtocol
    var documentPickerViewController: UIDocumentPickerViewController? = nil
    
    init(documentImportManager: DocumentImportManagerProtocol) {
        self.documentImportManager = documentImportManager
        
        super.init()
        
        setupDocumentPickerViewController()
    }
    
    private func setupDocumentPickerViewController() {
        guard let documentTypeTag = documentImportManager.documentTypeTag else { return }
        
        let types = UTType.types(tag: documentTypeTag,
                                 tagClass: UTTagClass.filenameExtension,
                                 conformingTo: nil)
        
        documentPickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: types,
                                                                      asCopy: true)
        
        documentPickerViewController?.delegate = self
        documentPickerViewController?.allowsMultipleSelection = true
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController,
                        didPickDocumentsAt urls: [URL]) {
        for url in urls {
            let isSecurityScopedResource = (url.startAccessingSecurityScopedResource() == true)
            let coordinator = NSFileCoordinator()
            var error: NSError? = nil
            
            coordinator.coordinate(readingItemAt: url,
                                   options: [],
                                   error: &error) { externalFileURL -> Void in
                
                save(from: externalFileURL)
                
                if (isSecurityScopedResource) {
                    url.stopAccessingSecurityScopedResource()
                }
            }
        }
    }
    
    func save(from url: URL) {
        do {
            try documentImportManager.save(from: url)
        } catch {
            print(error)
        }
    }
    
    // MARK: Helpers
    
    private func tempUrl(for fileName: String) -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))
    }
}
