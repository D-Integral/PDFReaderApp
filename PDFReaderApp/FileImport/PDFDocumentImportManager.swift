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
    override func documentFile(from fileUrl: URL) -> (any FileProtocol)? {
        guard let pdfDocument = PDFDocument(url: fileUrl) else {
            return nil
        }
        
        guard let fileData = pdfDocument.dataRepresentation() else {
            return nil
        }
        
        let documentAttributes = pdfDocument.documentAttributes
        let defaultDate = Date()
        let createdDate = documentAttributes?["CreationDate"] as? Date ?? defaultDate
        let modifiedDate = documentAttributes?["ModDate"] as? Date ?? defaultDate
        
        return DiskFile(name: fileUrl.lastPathComponent,
                        data: fileData,
                        createdDate: createdDate,
                        modifiedDate: modifiedDate,
                        fileType: .pdfDocument)
    }
    
    override var documentTypeTag: String? {
        return "pdf"
    }
}
