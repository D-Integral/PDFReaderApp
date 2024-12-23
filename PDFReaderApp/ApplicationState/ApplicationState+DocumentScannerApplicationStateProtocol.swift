//
//  ApplicationState+DocumentScannerApplicationStateProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 18/01/2024.
//

import Foundation
import NefertitiFile

extension ApplicationState: DocumentScannerApplicationStateProtocol {
    public var isDocumentCameraSupported: Bool {
        return documentCameraManager.isDocumentCameraSupported
    }
    
    public var lastScannedFile: (any NefertitiFileProtocol)? {
        return documentCameraManager.lastScannedFile
    }
    
    public var documentCameraRouter: RouterProtocol {
        return documentCameraManager.documentCameraRouter()
    }
    
}
