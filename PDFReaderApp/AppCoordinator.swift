//
//  AppCoordinator.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 29/12/2023.
//

import Foundation
import UIKit

class AppCoordinator {
    static let shared = AppCoordinator()
    
    let homeTabBarController: HomeTabBarController
    let fileStorage: FileStorageProtocol
    
    private init() {
        homeTabBarController = HomeTabBarController()
        fileStorage = DiskFileStorage()
        
        homeTabBarController.viewControllers = [filesNavigationController(),
                                                toolsNavigationController(),
                                                accountNavigationController()]
    }
    
    // MARK: Navigation controllers

    func navigationController(with viewController: UIViewController,
                              tabBarItem: UITabBarItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [viewController]
        navigationController.tabBarItem = tabBarItem
        
        return navigationController
    }
    
    func filesNavigationController() -> UINavigationController {
        return navigationController(with: MyFilesRouter().make(fileStorage: fileStorage),
                                    tabBarItem: filesTabBarItem())
    }
    
    func toolsNavigationController() -> UINavigationController {
        return navigationController(with: toolsViewController(),
                                    tabBarItem: toolsTabBarItem())
    }
    
    func accountNavigationController() -> UINavigationController {
        return navigationController(with: accountViewController(),
                                    tabBarItem: accountTabBarItem())
    }
    
    // MARK: Tab bar items
    
    func filesTabBarItem() -> UITabBarItem {
        return tabBarItem(withTitle: String(localized: "filesTabBarItemTitle"),
                          image: UIImage.iconFilesSelected.withTintColor(.iconGray),
                          selectedImage: UIImage.iconFilesSelected)
    }
    
    func toolsTabBarItem() -> UITabBarItem {
        return tabBarItem(withTitle: toolsTitle(),
                          image: UIImage.iconTools,
                          selectedImage: UIImage.iconTools.withTintColor(.iconPurple))
    }
    
    func accountTabBarItem() -> UITabBarItem {
        return tabBarItem(withTitle: String(localized: "accountTabBarItemTitle"),
                          image: UIImage.iconAccount,
                          selectedImage: UIImage.iconAccount.withTintColor(.iconPurple))
    }
    
    func tabBarItem(withTitle title: String,
                    image: UIImage,
                    selectedImage: UIImage) -> UITabBarItem {
        return UITabBarItem(title: title,
                            image: image,
                            selectedImage: selectedImage)
    }
    
    // MARK: View controllers
    
    func toolsViewController() -> UIViewController {
        let toolsViewController = AccountViewController()
        toolsViewController.title = toolsTitle()
        
        return toolsViewController
    }
    
    func accountViewController() -> UIViewController {
        let accountViewController = AccountViewController()
        accountViewController.title = String(localized: "accountViewControllerTitle")
        
        return accountViewController
    }
    
    // MARK: Reusable strings
    
    func toolsTitle() -> String {
        return String(localized: "toolsTitle")
    }
}