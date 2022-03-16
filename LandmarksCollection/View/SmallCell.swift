//
//  SmallCell.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class SmallCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func buildCell(landmark: Landmark) {
        image.image = landmark.image
        image.layer.cornerRadius = 10
        title.text = landmark.name
    }
}
