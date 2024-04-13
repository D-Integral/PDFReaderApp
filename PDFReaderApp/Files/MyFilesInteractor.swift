//
//  MyFilesInteractor.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 30/12/2023.
//

import Foundation

class MyFilesInteractor: InteractorProtocol {
    
    // MARK: - Properties
    
    var files: [any FileProtocol]? {
        return applicationState.files
    }
    
    let documentPickerManager: DocumentPickerManager
    
    private let applicationState: (FileManagerApplicationStateProtocol &
                                   DynamicUINotifierProtocol &
                                   SubscriptionApplicationStateProtocol)
    
    // MARK: - Life Cycle
    
    init(applicationState: (FileManagerApplicationStateProtocol &
                            DynamicUINotifierProtocol &
                            SubscriptionApplicationStateProtocol),
         documentImportManager: DocumentImportManagerProtocol) {
        self.applicationState = applicationState
        
        self.documentPickerManager = DocumentPickerManager(documentImportManager: documentImportManager)
    }
    
    // MARK: - File Management
    
    func deleteFile(withId fileId: UUID) {
        applicationState.delete(fileId)
    }
    
    func openedFile(withId fileId: UUID) {
        applicationState.opened(fileId)
    }
    
    public func rename(_ fileId: UUID,
                       to newName: String) {
        applicationState.rename(fileId, to: newName)
    }
    
    func sortedAndFilteredFiles(for queryOrNil: String?) -> [any FileProtocol] {
        let filteredFiles = filteredFiles(for: queryOrNil)
        let sortedFiles = (filteredFiles as? [DiskFile])?.sorted(by: >)
        
        return sortedFiles ?? filteredFiles
    }
    
    // MARK: - Dynamic UI
    
    func add(dynamicUI: any DynamicUIProtocol) {
        documentPickerManager.add(dynamicUI: dynamicUI)
        applicationState.add(dynamicUI: dynamicUI)
    }
    
    func remove(dynamicUI: any DynamicUIProtocol) {
        documentPickerManager.remove(dynamicUI: dynamicUI)
        applicationState.remove(dynamicUI: dynamicUI)
    }
    
    // MARK: - Private Functions
    
    private func filteredFiles(for queryOrNil: String?) -> [any FileProtocol] {
        guard let files = files else {
            return []
        }
        
        guard let query = queryOrNil,
              !query.isEmpty else {
            return files
        }
        
        return files.filter {
            return $0.title.lowercased().contains(query.lowercased())
        }
    }
    
    // MARK: - Subscription
    
//    func checkIfSubscribed(subscribedCompletionHandler: () -> (),
//                           notSubscribedCompletionHandler: () -> ()) {
//        applicationState.checkIfSubscribed {
//            subscribedCompletionHandler()
//        } notSubscribedCompletionHandler: {
//            notSubscribedCompletionHandler()
//        }
//    }
}
