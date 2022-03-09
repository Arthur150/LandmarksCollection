//
//  ViewController.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class LandmarkCollectionViewController: UICollectionViewController {
    
    enum Section: CaseIterable {
        case featured
        case favorites
        case rivers
        case lakes
        case mountains
    }
    
    enum Item: Hashable {
        case largeCell(Landmark,id:UUID = UUID())
        case smallCell(Landmark,id:UUID = UUID())
    }
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section,Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section,Item>{
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.featured,.favorites,.rivers,.lakes,.mountains])
        
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
                return self.createLargeCellSection()
            case .favorites:
                let section = self.createSmallCellSection()
                
                return section
            case .rivers:
                let section = self.createSmallCellSection()
                
                return section
            case .lakes:
                let section = self.createSmallCellSection()
                
                return section
            case .mountains:
                let section = self.createSmallCellSection()
                
                return section
            }
        }
        
        return layout
    }
    
    func createLargeCellSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
    
    func createSmallCellSection() -> NSCollectionLayoutSection {
        
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 5, bottom: 10, trailing: 5)
            
            return section
    }
    
}

