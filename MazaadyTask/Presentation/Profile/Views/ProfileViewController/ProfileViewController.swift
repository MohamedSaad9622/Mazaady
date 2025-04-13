
//
//  ProfileViewController.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit
import Combine

// MARK: - Section & Item Definitions

enum ProfileSection: Int, CaseIterable {
    case userData
    case products
    case advertisements
    case tags
}

enum ProfileItem: Hashable, Sendable {
    case user(UserData)
    case product(ProductModel)
    case advertisement(Advertisements)
    case tag(Tag)
}


class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ProfileSection, ProfileItem>!

    
    // MARK: - ViewModel & Combine
    
    private let viewModel: ProfileViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupCollectionView()
        configureDataSource()
        bindViewModel()
        
        // Load data
        viewModel.loadData()
    }
    
    // MARK: - Combine Bindings

    private func bindViewModel() {
        
        viewModel.$userData
            .combineLatest(viewModel.$products, viewModel.$advertisements, viewModel.$tags)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_, _, _, _) in
                self?.updateSnapshot()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showErrorAlert(message: error)
            }
            .store(in: &cancellables)
    }
    

    // MARK: - CollectionView Setup

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        registerCells()
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: "ProfileCell", bundle: nil),
                                 forCellWithReuseIdentifier: "ProfileCell")
        collectionView.register(TagCollectionCell.self, forCellWithReuseIdentifier: TagCollectionCell.reuseIdentifier)

        collectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "AdsCollectionViewCell")
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil),
                                 forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(SegmentHeaderView.self,
                                forSupplementaryViewOfKind: "segmentHeaderView",
                                withReuseIdentifier: SegmentHeaderView.reuseIdentifier)
        collectionView.register(SearchBarView.self,
                                forSupplementaryViewOfKind: "searchBarView",
                                withReuseIdentifier: SearchBarView.reuseIdentifier)
    }
    
    // MARK: - Diffable Data Source Configuration

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ProfileSection, ProfileItem>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard ProfileSection(rawValue: indexPath.section) != nil else { return nil }
            
            switch item {
            case .user(let userData):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return nil }
                cell.configCell(with: userData)
                return cell
                
            case .product(let product):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else { return nil }
                cell.configCell(with: product)
                return cell
                
            case .advertisement(let ad):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as? AdsCollectionViewCell else { return nil }
                cell.configure(with: ad)
                return cell
                
            case .tag(let tag):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionCell", for: indexPath) as? TagCollectionCell else { return nil }
                cell.configure(with: tag)
                if indexPath == IndexPath(item: 0, section: ProfileSection.tags.rawValue) {
                    cell.isSelected = true
                }
                return cell
            }
        }
        
        setupSupplementaryViewProvider()
    }
    
    func setupSupplementaryViewProvider() {

        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard let section = ProfileSection(rawValue: indexPath.section) else { return nil }

            if kind == "segmentHeaderView", section == .userData {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SegmentHeaderView.reuseIdentifier,
                    for: indexPath) as! SegmentHeaderView
                header.onSegmentChanged = { index in
                    print("Segment changed to \(index)")
                }
                return header
            } else if kind == "searchBarView", section == .userData {
                let searchHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SearchBarView.reuseIdentifier,
                    for: indexPath) as! SearchBarView
                searchHeader.onSearchTapped = { [weak self] keyword in
                    print("Searching for: \(keyword)")
                    self?.viewModel.searchProducts(keyword: keyword)
                }
                return searchHeader
            }

            return nil
        }

    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ProfileSection, ProfileItem>()
        snapshot.appendSections(ProfileSection.allCases)

        if let userData = viewModel.userData {
            snapshot.appendItems([.user(userData)], toSection: .userData)
        }

        snapshot.appendItems(viewModel.products.map { .product($0) }, toSection: .products)
        snapshot.appendItems(viewModel.advertisements.map { .advertisement($0) }, toSection: .advertisements)
        snapshot.appendItems(viewModel.tags.map { .tag($0) }, toSection: .tags)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }

}


extension ProfileViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex, environment) in
            guard let sectionType = ProfileSection(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .userData:
                return self.createHeaderSection()
            case .products:
                return ProfileViewController.createWaterFallLayout(env: environment, items: self.viewModel.products)
            case .advertisements:
                return self.createAdvertisementsSection()
            case .tags:
                return self.createTagsSection()
            }
        }
    }
    
    private func createHeaderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(265))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(265))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0)

        let segmentHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(40)),
            elementKind: "segmentHeaderView",
            alignment: .bottom
        )

        let searchHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(60)),
            elementKind: "searchBarView",
            alignment: .bottom,
            absoluteOffset: CGPoint(x: 0, y: 50)
        )

        section.boundarySupplementaryItems = [segmentHeader, searchHeader]

        return section
    }

    
    static func createWaterFallLayout(env: NSCollectionLayoutEnvironment, items: [ProductModel]) -> NSCollectionLayoutSection {

        let sectionHorizontalSpacing: CGFloat = 10

        let layout = WaterfallTrueCompositionalLayout.makeLayoutSection(
            config: .init(
                columnCount: 3,
                interItemSpacing: 10,
                sectionHorizontalSpacing: sectionHorizontalSpacing,
                itemCountProvider: {
                    return items.count
                },
                itemHeightProvider: { index, itemWidth in
                    let product = items[index]

                    var height : CGFloat = 160
                    if product.offer != nil  {
                        height += 36
                    }
                    if product.endDate != nil {
                        height += 65
                    }
                    return height
                }
            ),
            enviroment: env,
            sectionIndex: 1
        )

        layout.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: sectionHorizontalSpacing,
            bottom: 20,
            trailing: sectionHorizontalSpacing
        )
        return layout
    }

    
    private func createAdvertisementsSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(147))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(147))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createTagsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(80),
            heightDimension: .absolute(36)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 5, bottom: 4, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.orthogonalScrollingBehavior = .none

        return section
    }
    
    
}

