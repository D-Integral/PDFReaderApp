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
    
    let title: String
    
    init(interactor: MyFilesInteractor, title: String) {
        self.interactor = interactor
        self.title = title
    }
    
    func save(from url: URL) throws {
        try interactor.save(from: url)
    }
}
