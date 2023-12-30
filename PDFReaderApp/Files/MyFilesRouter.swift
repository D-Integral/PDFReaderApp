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
        let presenter = MyFilesPresenter(interactor: MyFilesInteractor(fileStorage: fileStorage),
                                         title: String(localized: "myFilesViewControllerTitle"))
        return MyFilesViewController(presenter: presenter)
    }
}
