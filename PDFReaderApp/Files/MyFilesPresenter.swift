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
    
    let documentPickerManager: DocumentPickerManager
    
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
}
