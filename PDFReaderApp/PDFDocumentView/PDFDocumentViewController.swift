//
//  PDFDocumentViewController.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 03/01/2024.
//

import UIKit
import PDFKit

class PDFDocumentViewController: UIViewController {
    
    // MARK: - Properties
    
    let diskFile: DiskFile?
    
    let pdfView = PDFView()
    
    // MARK: - Life Cycle
    
    init(diskFile: DiskFile) {
        self.diskFile = diskFile
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.diskFile = nil
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPdfView()
        
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupPdfView() {
        if diskFile?.fileType == .pdfDocument,
           let pdfDocumentData = diskFile?.data {
            pdfView.document = PDFDocument(data: pdfDocumentData)
        }
        
        pdfView.autoresizesSubviews = true
        pdfView.displayDirection = .vertical
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        pdfView.displaysAsBook = true
        
        view.addSubview(pdfView)
    }
    
    private func setupConstraints() {
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
    }
}