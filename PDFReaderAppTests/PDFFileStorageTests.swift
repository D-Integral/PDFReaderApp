//
//  PDFFileStorageTests.swift
//  PDFReaderAppTests
//
//  Created by Dmytro Skorokhod on 30/12/2023.
//

import XCTest
@testable import PDFReaderApp
import PDFKit

final class PDFFileStorageTests: XCTestCase {
    
    let testFileName = "CV Dmytro Skorokhod 12:26:2023"
    let pdfFileStorage = PDFFileStorage()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFileSavingAndDeleting() throws {
        defer {
            pdfFileStorage.delete(testFileName)
            XCTAssertTrue(pdfFileStorage.filesCount == 0)
        }
        
        guard let fileUrl = Bundle.main.url(forResource: testFileName, withExtension: "pdf") else {
            XCTFail("The test PDF file URL is broken.")
            return
        }
        
        guard let testPdfDocument = PDFDocument(url: fileUrl) else {
            XCTFail("An attempt to initialize a test PDF document using the provided file URL has been unsuccessful.")
            return
        }
        
        let documentAttributes = testPdfDocument.documentAttributes
        let defaultDate = Date()
        let createdDate = documentAttributes?["CreationDate"] as? Date ?? defaultDate
        let modifiedDate = documentAttributes?["ModDate"] as? Date ?? defaultDate
        
        XCTAssertNotNil(testPdfDocument)
        
        guard let diskFileData = testPdfDocument.dataRepresentation() else {
            XCTFail("An attempt to convert the test PDF document into data has failed.")
            return
        }
        
        let diskFile = DiskFile(name: testFileName,
                                data: diskFileData,
                                createdDate: createdDate,
                                modifiedDate: modifiedDate,
                                fileType: .pdfDocument)
        XCTAssertNotNil(diskFile)
        
        XCTAssertTrue(pdfFileStorage.filesCount == 0)
        
        do {
            try pdfFileStorage.save(diskFile)
        } catch {
            XCTFail("An attempt to save the PDF file to the storage has failed with error: \(error.localizedDescription)")
            return
        }
        
        XCTAssertTrue(pdfFileStorage.filesCount == 1)
        
        let retrievedFile = pdfFileStorage.file(withName: testFileName)
        XCTAssertNotNil(retrievedFile)
        XCTAssertTrue(retrievedFile?.name == testFileName)
        XCTAssertNotNil(retrievedFile?.data)
        XCTAssertTrue(retrievedFile?.createdDate == createdDate)
        XCTAssertTrue(retrievedFile?.modifiedDate == modifiedDate)
        XCTAssertTrue(retrievedFile?.fileType == .pdfDocument)
        
        guard let data = retrievedFile?.data else {
            XCTFail("Data from saved file is nil")
            return
        }
        
        let pdfDocument = PDFDocument(data: data)
        XCTAssertNotNil(pdfDocument)
        XCTAssertTrue(pdfDocument?.pageCount == 4)
    }
    
}
