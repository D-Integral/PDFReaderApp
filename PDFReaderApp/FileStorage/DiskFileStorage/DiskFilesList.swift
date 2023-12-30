//
//  DiskFilesList.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

struct DiskFilesList: FilesListProtocol {
    init(diskFiles: [String : DiskFile]) {
        self.diskFiles = diskFiles
    }
    
    var files: [String: FileProtocol] {
        get {
            return diskFiles
        }
        set {
            diskFiles = newValue as? [String: DiskFile] ?? [String: DiskFile]()
        }
    }
    
    private var diskFiles: [String: DiskFile]
}
