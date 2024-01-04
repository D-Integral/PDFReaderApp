//
//  DocumentImportManager.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 31/12/2023.
//

import Foundation
import UIKit
import PDFKit

final class PDFDocumentImportManager: DocumentImportManager {
    override func documentFile(from fileUrl: URL,
                               completionHandler: @escaping ((any FileProtocol)?,
                                                             DocumentImportError?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let pdfDocument = PDFDocument(url: fileUrl) else {
                completionHandler(nil,
                                  .documentCanNotBeInstantiatedUsingProvidedUrl)
                return
            }
            
            guard let fileData = pdfDocument.dataRepresentation() else {
                completionHandler(nil,
                                  .documentCanNotBeConvertedToData)
                return
            }
            
            let documentAttributes = pdfDocument.documentAttributes
            let defaultDate = Date()
            let createdDate = documentAttributes?["CreationDate"] as? Date ?? defaultDate
            let modifiedDate = documentAttributes?["ModDate"] as? Date ?? defaultDate
            
            completionHandler(DiskFile(name: fileUrl.lastPathComponent,
                                       data: fileData,
                                       createdDate: createdDate,
                                       modifiedDate: modifiedDate,
                                       fileType: .pdfDocument),
                              nil)
        }
        
        
    }
    
    override var documentTypeTag: String? {
        return "pdf"
    }
    
    var securityScopedResources = Set<URL>()
    
    override func importDocuments(at urls: [URL],
                                  completionHandler: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let dispatchGroup = DispatchGroup()
            let queue = OperationQueue()
            queue.qualityOfService = .userInitiated
            
            for url in urls {
                dispatchGroup.enter()
                self?.startAccessingSecurityScopedResource(for: url)
                
                NSFileCoordinator().coordinate(with: [.readingIntent(with: url)],
                                               queue: queue) { [weak self] error in
                    self?.onFileCoordinatorCompleted(for: url)
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                completionHandler()
            }
        }
    }
    
    private func onFileCoordinatorCompleted(for url: URL) {
        do {
            try save(from: url)
        } catch {
            print(error)
        }
        
        stopAccessingSecurityScopedResource(for: url)
    }
    
    private func startAccessingSecurityScopedResource(for url: URL) {
        url.stopAccessingSecurityScopedResource()
        securityScopedResources.remove(url)
    }
    
    private func stopAccessingSecurityScopedResource(for url: URL) {
        url.stopAccessingSecurityScopedResource()
        securityScopedResources.remove(url)
    }
}
