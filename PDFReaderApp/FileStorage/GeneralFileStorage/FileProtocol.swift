//
//  FileProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

protocol FileProtocol: Codable {
    var name: String { get set }
    var data: Data { get set }
    var createdDate: Date { get set }
    var modifiedDate: Date { get set }
    var fileType: FileType { get set }
}
