//
//  ViewController.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class LandmarkCollectionViewController: UICollectionViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    enum Item: Hashable {
        case largeCell(Landmark)
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
            case .largeCell(let landmark):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "largeCell", for: indexPath) as! LargeCell
                cell.image.image = landmark.image
                cell.title.text = landmark.name
                return cell
            }
        })
    }
    
    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section,Item>{
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.main])
        
        Section.allCases.forEach { section in
            switch section {
            case .main:
                let items = LandmarkRepository.shared.loadLandmarks().map { landmark in
                    return Item.largeCell(landmark)
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
            case .main:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                return section
            }
        }
        
        return layout
    }
    
}

