//
//  ViewController.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 28/12/2023.
//

import UIKit

class MyFilesViewController: UIViewController {
    struct Constants {
        struct ImportButtonLayout {
            static let side = 60.0;
            static let rightOffset = -15.0
            static let bottomOffset = -20.0
        }
    }
    
    let presenter: MyFilesPresenter?
    
    let importButton = UIButton(type: .custom)
    
    init(presenter: MyFilesPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil,
                   bundle: nil)
        
        self.title = presenter.title
    }
    
    required init?(coder: NSCoder) {
        self.presenter = nil
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupImportButton()
        setupConstraints()
    }
    
    private func setupImportButton() {
        let importButtonImage = UIImage(named: "button_import") as UIImage?
        
        importButton.setImage(importButtonImage, for: .normal)
        importButton.addTarget(self,
                               action: #selector(importAction),
                               for: .touchUpInside)
        view.addSubview(importButton)
    }
    
    private func setupConstraints() {
        importButton.translatesAutoresizingMaskIntoConstraints = false
        importButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                            constant: Constants.ImportButtonLayout.rightOffset).isActive = true
        importButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                             constant: Constants.ImportButtonLayout.bottomOffset).isActive = true
        importButton.widthAnchor.constraint(equalToConstant: Constants.ImportButtonLayout.side).isActive = true
        importButton.heightAnchor.constraint(equalToConstant: Constants.ImportButtonLayout.side).isActive = true
    }
    
    @objc private func importAction() {
        guard let documentPicker = presenter?.documentPickerViewController else { return }
        
        self.present(documentPicker,
                     animated: true,
                     completion: nil)
    }
}
