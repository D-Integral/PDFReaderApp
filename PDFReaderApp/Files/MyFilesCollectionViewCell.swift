//
//  MyFilesCollectionViewCell.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 03/01/2024.
//

import UIKit

class MyFilesCollectionViewCell: UICollectionViewCell {
    let documentPreviewImageView = UIImageView()
    let documentTitleLabel = UILabel()
    let documentModifiedDateLabel = UILabel()
    let documentSizeLabel = UILabel()
    let moreButton = UIButton(type: .custom)
    
    var diskFile: DiskFile? {
        didSet {
            documentTitleLabel.text = diskFile?.name ?? ""
        }
    }
    
    override init(frame: CGRect) {
        self.diskFile = nil
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    init(diskFile: DiskFile? = nil) {
        self.diskFile = diskFile
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.diskFile = nil
        
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        documentTitleLabel.numberOfLines = 2
        
        addSubview(documentTitleLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        documentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        documentTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        documentTitleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        documentTitleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        documentTitleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
    }
}
