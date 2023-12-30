//
//  DiskFileStorage.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation

class DiskFileStorage: FileStorageProtocol {
    
    init() {
        do {
            self.filesList = try retrieveFilesList()
        } catch {
            print(error)
        }
        
        if nil == self.filesList {
            self.filesList = DiskFilesList(diskFiles: [String : DiskFile]())
        }
    }
    
    // MARK: FileStorageProtocol
    
    var fileNames: [String] {
        return Array(arrayLiteral: filesList?.files.keys) as? [String] ?? []
    }
    
    var filesCount: Int {
        return filesList?.files.count ?? 0
    }
    
    func file(withName fileName: String) -> FileProtocol? {
        return filesList?.files[fileName]
    }
    
    func save(_ file: FileProtocol) throws {
        guard let diskFile = file as? DiskFile else {
            throw DiskFileStorageError.wrongFileType
        }
        
        filesList?.files[diskFile.name] = diskFile
        
        synchronize()
    }
    
    func delete(_ fileName: String) {
        filesList?.files[fileName] = nil
        
        synchronize()
    }
    
    // MARK: Files List
    
    private var filesList: DiskFilesList? = nil
    
    func synchronize() {
        do {
            try saveFilesList()
        } catch {
            print(error)
        }
    }
    
    func saveFilesList() throws {
        guard let url = filesListURL else {
            throw DiskFileStorageError.filesListUrlIsBroken
        }
        
        let jsonData = try JSONEncoder().encode(self.filesList)
        try jsonData.write(to: url)
    }
    
    func retrieveFilesList() throws -> DiskFilesList? {
        guard let url = filesListURL else {
            throw DiskFileStorageError.filesListUrlIsBroken
        }
        
        let jsonData = try Data(contentsOf: url)
        return try JSONDecoder().decode(DiskFilesList.self,
                                        from: jsonData)
    }
    
    private var filesListURL: URL? {
        let fileManager = FileManager.default
        let documentDirectoryURL = (fileManager.urls(for: .documentDirectory,
                                                     in: .userDomainMask)).last as? NSURL
        
        return documentDirectoryURL?.appendingPathComponent("filesList") as? URL
    }
}
