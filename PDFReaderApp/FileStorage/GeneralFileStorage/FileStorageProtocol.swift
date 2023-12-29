//
//  FileStorageProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

protocol FileStorageProtocol {
    var files: [FileProtocol] { get }
    
    func save(_ file: FileProtocol) throws
    func delete(_ fileName: String)
}
