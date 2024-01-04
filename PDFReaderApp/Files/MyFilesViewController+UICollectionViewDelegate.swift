//
//  MyFilesViewController+UICollectionViewDelegate.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 04/01/2024.
//

import Foundation
import UIKit

extension MyFilesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath
    ) {
        guard let diskFile = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        navigationController?.present(PDFDocumentRouter().make(diskFile: diskFile),
                                      animated: true)
    }
}
