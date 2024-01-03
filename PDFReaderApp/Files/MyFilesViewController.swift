//
//  ViewController.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 28/12/2023.
//

import UIKit
import PDFKit

class MyFilesViewController: UIViewController {
    // MARK: - Definitions
    
    struct Constants {
        struct ImportButtonLayout {
            static let side = 60.0;
            static let rightOffset = -15.0
            static let bottomOffset = -20.0
        }
        
        struct FilesList {
            struct Layout {
                static let contentInset = 15.0
            }
            
            struct Reuse {
                static let cellIdentifier = "MyFilesCollectionViewCell"
            }
        }
    }
    
    enum Section {
      case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, DiskFile>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DiskFile>
    
    // MARK: - Properties
    
    let presenter: MyFilesPresenter?
    
    private lazy var dataSource = makeDataSource()
    
    private let importButton = UIButton(type: .custom)
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Life Cycle
    
    init(presenter: MyFilesPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil,
                   bundle: nil)
        
        self.title = presenter.title
        
        self.presenter?.add(dynamicUI: self)
    }
    
    required init?(coder: NSCoder) {
        self.presenter = nil
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchController()
        setupCollectionView()
        setupImportButton()
        setupConstraints()
        
        updateDynamicUI()
    }
    
    // MARK: - Collection View
    
    func collectionViewLayout() -> UICollectionViewLayout {
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0))
      let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(2/3))
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitem: fullPhotoItem,
        count: 1)
      let section = NSCollectionLayoutSection(group: group)
      let layout = UICollectionViewCompositionalLayout(section: section)
      return layout
    }
    
    // MARK: - DynamicUIProtocol
    
    override func updateDynamicUI() {
        applySnapshot()
    }
    
    // MARK: - Setup
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = String(localized: "searchPdfDocuments")
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.register(MyFilesCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.FilesList.Reuse.cellIdentifier)
        collectionView.delegate = self
        
        view.addSubview(collectionView)
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.FilesList.Layout.contentInset).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -Constants.FilesList.Layout.contentInset).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -Constants.FilesList.Layout.contentInset).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: Constants.FilesList.Layout.contentInset).isActive = true
        
        importButton.translatesAutoresizingMaskIntoConstraints = false
        importButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                            constant: Constants.ImportButtonLayout.rightOffset).isActive = true
        importButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                             constant: Constants.ImportButtonLayout.bottomOffset).isActive = true
        importButton.widthAnchor.constraint(equalToConstant: Constants.ImportButtonLayout.side).isActive = true
        importButton.heightAnchor.constraint(equalToConstant: Constants.ImportButtonLayout.side).isActive = true
    }
    
    // MARK: - Private Functions
    
    private func makeDataSource() -> DataSource {
      let dataSource = DataSource(collectionView: collectionView,
                                  cellProvider: { (collectionView, indexPath, diskFile) -> UICollectionViewCell? in
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.FilesList.Reuse.cellIdentifier,
                                                        for: indexPath) as? MyFilesCollectionViewCell
          cell?.diskFile = diskFile
          
          return cell
      })
        
      return dataSource
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        let files = presenter?.filteredFiles(for: searchController.searchBar.text) as? [DiskFile] ?? []
        snapshot.appendItems(files)
        dataSource.apply(snapshot,
                         animatingDifferences: true)
    }
    
    @objc private func importAction() {
        guard let documentPicker = presenter?.documentPickerViewController else { return }
        
        self.present(documentPicker,
                     animated: true,
                     completion: nil)
    }
}

// MARK: - UICollectionViewDelegate

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
