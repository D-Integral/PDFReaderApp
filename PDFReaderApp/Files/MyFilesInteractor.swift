//
//  MyFilesInteractor.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 30/12/2023.
//

import Foundation
import PDFKit

class MyFilesInteractor: InteractorProtocol {
    let fileStorage: FileStorageProtocol
    
    init(fileStorage: FileStorageProtocol) {
        self.fileStorage = fileStorage
    }
    
    func save(from url: URL) throws {
        guard let file = pdfDocumentFile(from: url) else {
            throw MyFilesInteractorError.fileNotInstantiatedUsingProvidedUrl
        }
        
        save(file)
        
        print("\n")
        print("Files Count")
        print(fileStorage.filesCount)
        print("\n")
    }
    
    func save(_ file: FileProtocol) {
        do {
            try fileStorage.save(file)
        } catch {
            print("An attempt to save the PDF file to the storage has failed with error: \(error.localizedDescription)")
            return
        }
    }
    
    func pdfDocumentFile(from fileUrl: URL) -> FileProtocol? {
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
}
