//
//  FileStorageProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

protocol FileStorageProtocol {
    var fileNames: [String] { get }
    var filesCount: Int { get }
    
    func file(withName fileName: String) -> FileProtocol?
    
    func save(_ file: FileProtocol) throws
    func delete(_ fileName: String)
}
