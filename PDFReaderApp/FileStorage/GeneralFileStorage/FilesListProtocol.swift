//
//  FilesListProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

protocol FilesListProtocol: Codable {
    var files: [String: FileProtocol] { get set }
}
