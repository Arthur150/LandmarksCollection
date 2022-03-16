//
//  HeaderCollectionReusableView.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var title: UILabel!
    
    func build(section: LandmarkCollectionViewController.Section){
        title.text = section.rawValue
    }
}
