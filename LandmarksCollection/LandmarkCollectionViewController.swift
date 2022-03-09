//
//  ViewController.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class LandmarkCollectionViewController: UICollectionViewController {

    var landmarks: [Landmark]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        landmarks = LandmarkRepository.shared.landmarks
    }


}

