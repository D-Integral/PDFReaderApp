//
//  DocumentImportError.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 31/12/2023.
//

import Foundation

import Foundation

enum DocumentImportError: Error {
    case documentCanNotBeInstantiatedUsingProvidedUrl
    case documentCanNotBeConvertedToData
}
