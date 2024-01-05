//
//  DiskFilesList.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

struct DiskFilesList: FilesListProtocol {
    init(diskFiles: [UUID : DiskFile]) {
        self.diskFiles = diskFiles
    }
    
    var files: [UUID: any FileProtocol] {
        get {
            return diskFiles
        }
        set {
            diskFiles = newValue as? [UUID: DiskFile] ?? [UUID: DiskFile]()
        }
    }
    
    private var diskFiles: [UUID: DiskFile]
}
