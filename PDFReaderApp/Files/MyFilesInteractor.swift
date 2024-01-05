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
}
