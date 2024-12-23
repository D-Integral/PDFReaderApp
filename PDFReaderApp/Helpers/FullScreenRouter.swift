//
//  DocumentRouter.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 08/01/2024.
//

import Foundation
import UIKit

class FullScreenRouter: RouterProtocol {
    public func make() -> UIViewController {
        return UIViewController()
    }
    
    public func fullScreenNavigationController(with viewController: UIViewController,
                                               navigationBarHidden: Bool = false) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen
        nav.isModalInPresentation = false
        nav.modalTransitionStyle = .crossDissolve
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        nav.navigationBar.isTranslucent = false
        
        nav.setNavigationBarHidden(navigationBarHidden,
                                   animated: false)
        
        return nav
    }
}
