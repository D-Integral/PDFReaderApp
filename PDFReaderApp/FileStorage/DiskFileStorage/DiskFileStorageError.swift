//
//  DiskFileStorageError.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

enum DiskFileStorageError: Error {
    case filesListUrlIsBroken
    case wrongFileType
}
