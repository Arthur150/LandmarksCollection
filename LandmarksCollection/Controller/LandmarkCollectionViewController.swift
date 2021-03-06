//
//  ViewController.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class LandmarkCollectionViewController: UICollectionViewController {
    
    enum Section: String, CaseIterable {
        case featured = "✨ Featured"
        case favorites = "⭐ Favorites"
        case rivers = "🐟 Rivers"
        case lakes = "💧 Lakes"
        case mountains = "⛰️ Mountains"
    }
    
    enum Item: Hashable {
        case largeCell(Landmark,id:UUID = UUID())
        case smallCell(Landmark,id:UUID = UUID())
    }
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section,Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        
        configureDataSource()
        collectionView.collectionViewLayout = createLayout()
        loadInitialState()
    }
    
    private func configureDataSource(){
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .largeCell(let landmark, _):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "largeCell", for: indexPath) as! LargeCell
                cell.buildCell(landmark: landmark)
                return cell
            case .smallCell(let landmark, _):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCell", for: indexPath) as! SmallCell
                cell.buildCell(landmark: landmark)
                return cell
            }
        })
        
        diffableDataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            switch elementKind {
            case UICollectionView.elementKindSectionHeader:
                let section = self.diffableDataSource.sectionIdentifier(for: indexPath.section)!
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
                header.build(section: section)
                
                return header
            default:
                return nil
            }
        }
    }
    
    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section,Item>{
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.featured,.favorites,.mountains,.rivers,.lakes])
        
        Section.allCases.forEach { section in
            switch section {
            case .featured:
                let items = LandmarkRepository.shared.getLandmarksFeatured().map { landmark in
                    return Item.largeCell(landmark)
                }
                snapshot.appendItems(items, toSection: section)
            case .favorites:
                let items = LandmarkRepository.shared.getLandmarksFavorites().map { landmark in
                    return Item.smallCell(landmark)
                }
                snapshot.appendItems(items, toSection: section)
            case .rivers:
                
                let items = LandmarkRepository.shared.getLandmarksCategory(category: .river).map { landmark in
                    return Item.smallCell(landmark)
                }
                snapshot.appendItems(items, toSection: section)
            case .lakes:
                
                let items = LandmarkRepository.shared.getLandmarksCategory(category: .lakes).map { landmark in
                    return Item.smallCell(landmark)
                }
                snapshot.appendItems(items, toSection: section)
            case .mountains:
                
                let items = LandmarkRepository.shared.getLandmarksCategory(category: .mountains).map { landmark in
                    return Item.smallCell(landmark)
                }
                snapshot.appendItems(items, toSection: section)
            }
        }
        
        return snapshot
    }
    
    private func loadInitialState() {
        let snapshot = createSnapshot()
        diffableDataSource.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, collectionLayoutEnvironment in
            guard let self = self,
                  let section = self.diffableDataSource.sectionIdentifier(for: sectionIndex) else {
                return nil
            }
            
            switch section {
            case .featured:
                return self.createLargeCellSection(sectionType: section,environment: collectionLayoutEnvironment)
            case .favorites:
                let section = self.createSmallCellSection(sectionType: section)
                
                return section
            case .rivers:
                let section = self.createSmallCellSection(sectionType: section)
                
                return section
            case .lakes:
                let section = self.createSmallCellSection(sectionType: section)
                
                return section
            case .mountains:
                let section = self.createSmallCellSection(sectionType: section)
                
                return section
            }
        }
        
        return layout
    }
    
    func createLargeCellSection(sectionType: Section, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        switch (environment.traitCollection.horizontalSizeClass, environment.traitCollection.verticalSizeClass) {
        case (.compact,_):
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        default:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
    
    func createSmallCellSection(sectionType: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetailLandmark"){
            if let destination = segue.destination as? DetailLandmarkViewController{
                guard let indexPath = collectionView.indexPath(for: sender as! UICollectionViewCell), let section = diffableDataSource.sectionIdentifier(for: indexPath.section) else {
                    return
                }
                switch section {
                case .featured:
                    destination.landmark = LandmarkRepository.shared.getLandmarksFeatured()[collectionView.indexPath(for: sender as! UICollectionViewCell)!.item]
                case .favorites:
                    destination.landmark = LandmarkRepository.shared.getLandmarksFavorites()[collectionView.indexPath(for: sender as! UICollectionViewCell)!.item]
                case .mountains:
                    destination.landmark = LandmarkRepository.shared.getLandmarksCategory(category: .mountains)[collectionView.indexPath(for: sender as! UICollectionViewCell)!.item]
                case .lakes:
                    destination.landmark = LandmarkRepository.shared.getLandmarksCategory(category: .lakes)[collectionView.indexPath(for: sender as! UICollectionViewCell)!.item]
                case .rivers:
                    destination.landmark = LandmarkRepository.shared.getLandmarksCategory(category: .river)[collectionView.indexPath(for: sender as! UICollectionViewCell)!.item]
                }
                
            }
        }
    }
    
}

