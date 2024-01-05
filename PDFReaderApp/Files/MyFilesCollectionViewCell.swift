//
//  MyFilesCollectionViewCell.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 03/01/2024.
//

import UIKit

class MyFilesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Definitions
    
    struct Constants {
        struct TitleLabel {
            static let height = 96.0
        }
        
        struct MoreButton {
            static let height = 12.0
            static let width = 24.0
            static let insets = NSDirectionalEdgeInsets(top: 10.0,
                                                        leading: 20.0,
                                                        bottom: 0.0,
                                                        trailing: 20.0)
        }
    }
    
    // MARK: - Properties
    
    let documentPreviewImageView = UIImageView()
    let documentTitleLabel = UILabel()
    let documentModifiedDateLabel = UILabel()
    let documentSizeLabel = UILabel()
    let moreButton = UIButton(type: .custom)
    
    var moreActionBlock: ((UUID?) -> ())? = nil
    
    var diskFile: DiskFile? {
        didSet {
            documentTitleLabel.text = diskFile?.name ?? ""
        }
    }
    
    // MARK: - Initialization
    
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
    
    // MARK: - Setup
    
    private func setupUI() {
        setupDocumentTitleLabel()
        setupMoreButton()
        
        setupConstrains()
    }
    
    private func setupDocumentTitleLabel() {
        documentTitleLabel.numberOfLines = 2
        
        addSubview(documentTitleLabel)
    }
    
    private func setupMoreButton() {
        let moreButtonImage = UIImage(named: "button_more_cell") as UIImage?
        
        moreButton.setImage(moreButtonImage, for: .normal)
        moreButton.addTarget(self,
                             action: #selector(moreAction),
                             for: .touchUpInside)
        moreButton.configuration?.contentInsets = Constants.MoreButton.insets
        
        addSubview(moreButton)
    }
    
    private func setupConstrains() {
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        let height = Constants.MoreButton.height + Constants.MoreButton.insets.top + Constants.MoreButton.insets.bottom
        moreButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        let width = Constants.MoreButton.width + Constants.MoreButton.insets.leading + Constants.MoreButton.insets.trailing
        moreButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        documentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        documentTitleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        documentTitleLabel.bottomAnchor.constraint(equalTo: moreButton.topAnchor).isActive = true
        documentTitleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        documentTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.TitleLabel.height).isActive = true
    }
    
    // MARK: - Private Functions
    
    @objc private func moreAction() {
        guard let moreActionBlock = moreActionBlock else { return }
        
        moreActionBlock(diskFile?.id)
    }
}
