//
//  LandmarkDetailViewController.swift
//  LandmarksCollection
//
//  Created by lpiem on 16/03/2022.
//

import UIKit

class DetailLandmarkViewController: UIViewController {
    var landmark : Landmark!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var parkLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = landmark.name
        
        imageView.image = landmark.image
        
      
        detailLabel.text = landmark.description
        locationlabel.text = "Location : \(landmark.state), \(landmark.city)"
        categoryLabel.text = "Category : \(landmark.category.rawValue)"
        parkLabel.text = "Park : \(landmark.park)"
    }
}
