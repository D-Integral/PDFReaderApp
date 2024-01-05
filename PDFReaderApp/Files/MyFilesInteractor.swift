//
//  MyFilesInteractor.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 30/12/2023.
//

import Foundation

class MyFilesInteractor: InteractorProtocol {
    var files: [any FileProtocol]? {
        return fileStorage.files()
    }
    
    private let fileStorage: FileStorageProtocol
    
    init(fileStorage: FileStorageProtocol) {
        self.fileStorage = fileStorage
    }
    
    func deleteFile(withId fileId: UUID) {
        fileStorage.delete(fileId)
    }
    
    func sortedAndFilteredFiles(for queryOrNil: String?) -> [any FileProtocol] {
        return filteredFiles(for: queryOrNil).sorted { fileA, fileB in
            return fileA.modifiedDate > fileB.modifiedDate
        }
    }
    
    private func filteredFiles(for queryOrNil: String?) -> [any FileProtocol] {
        guard let files = files else {
            return []
        }
        
        guard let query = queryOrNil,
              !query.isEmpty else {
            return files
        }
        
        return files.filter {
            return $0.name.lowercased().contains(query.lowercased())
        }
    }
}
