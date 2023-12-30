//
//  HomeTabBarController.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 28/12/2023.
//

import UIKit

class HomeTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedIndex = 0
        tabBar.tintColor = .iconPurple
        tabBar.unselectedItemTintColor = .iconGray
    }
 }
