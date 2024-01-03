//
//  MyFilesPresenter.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 30/12/2023.
//

import Foundation
import UIKit

class MyFilesPresenter: PresenterProtocol {
    private let interactor: MyFilesInteractor
    
    private let documentPickerManager: DocumentPickerManager
    
    let title: String
    
    init(interactor: MyFilesInteractor,
         documentImportManager: DocumentImportManagerProtocol,
         title: String) {
        self.interactor = interactor
        self.documentPickerManager = DocumentPickerManager(documentImportManager: documentImportManager)
        self.title = title
    }
    
    var documentPickerViewController: UIDocumentPickerViewController? {
        return documentPickerManager.documentPickerViewController
    }
    
    func add(dynamicUI: DynamicUIProtocol) {
        documentPickerManager.add(dynamicUI: dynamicUI)
    }
    
    func remove(dynamicUI: DynamicUIProtocol) {
        documentPickerManager.remove(dynamicUI: dynamicUI)
    }
    
    func filteredFiles(for queryOrNil: String?) -> [any FileProtocol] {
        let files = files()
        
        guard let query = queryOrNil,
              !query.isEmpty else {
            return files
        }
        
        return files.filter {
            return $0.name.lowercased().contains(query.lowercased())
        }
    }
    
    private func files() -> [any FileProtocol] {
        return interactor.files ?? []
    }
}
