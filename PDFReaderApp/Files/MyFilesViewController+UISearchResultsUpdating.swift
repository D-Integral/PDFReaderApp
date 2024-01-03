//
//  MyFilesViewController+UISearchResultsUpdating.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 03/01/2024.
//

import Foundation
import UIKit

extension MyFilesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        updateDynamicUI()
    }
}
