//
//  MyFilesViewController+UIDocumentPickerDelegate.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 30/12/2023.
//

import Foundation
import UIKit

extension MyFilesViewController: UIDocumentPickerDelegate {

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
    
    // MARK: Helpers
    
    private func tempUrl(for fileName: String) -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))
    }
}
