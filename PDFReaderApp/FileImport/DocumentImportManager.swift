//
//  DocumentImportManager.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 31/12/2023.
//

import Foundation

class DocumentImportManager: NSObject, DocumentImportManagerProtocol {
    // MARK: DocumentImportManagerProtocol
    
    var fileStorage: FileStorageProtocol
    
    var documentTypeTag: String? {
        return nil
    }
    
    required init(fileStorage: FileStorageProtocol) {
        self.fileStorage = fileStorage
    }
    
    func save(from url: URL) throws {
        guard let file = documentFile(from: url) else {
            throw DocumentImportError.documentCanNotBeInstantiatedUsingProvidedUrl
        }
        
        save(file)
    }
    
    func documentFile(from fileUrl: URL) -> (any FileProtocol)? {
        return nil
    }
    
    func importDocuments(at urls: [URL],
                         completionHandler: @escaping () -> ()) { }
    
    // MARK: Private Methods
    
    private func save(_ file: any FileProtocol) {
        do {
            try fileStorage.save(file)
        } catch {
            print("An attempt to save the file \"\(file.name)\" to the storage has failed with the following error: \(error.localizedDescription)")
            return
        }
    }
}
