//
//  DiskFile.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

struct DiskFile: FileProtocol {
    var name: String
    var data: Data
    var createdDate: Date
    var modifiedDate: Date
    var fileType: FileType
}
