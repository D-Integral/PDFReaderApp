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
    
    var files: [any FileProtocol] {
        return interactor.files ?? []
    }
    
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
}
