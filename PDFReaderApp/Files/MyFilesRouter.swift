//
//  MyFilesRouter.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 31/12/2023.
//

import Foundation
import UIKit

class MyFilesRouter: RouterProtocol {
    func make(fileStorage: FileStorageProtocol) -> UIViewController {
        let documentImportManager = PDFDocumentImportManager(fileStorage: fileStorage)
        let interactor = MyFilesInteractor(fileStorage: fileStorage)
        let presenter = MyFilesPresenter(interactor: interactor,
                                         documentImportManager: documentImportManager,
                                         title: String(localized: "myFilesViewControllerTitle"))
        
        return MyFilesViewController(presenter: presenter)
    }
}
