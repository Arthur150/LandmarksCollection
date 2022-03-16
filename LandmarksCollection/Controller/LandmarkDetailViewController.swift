//
//  LandmarkDetailViewController.swift
//  LandmarksCollection
//
//  Created by lpiem on 16/03/2022.
//

import UIKit
import MapKit

class DetailLandmarkViewController: UIViewController {
    var landmark : Landmark!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var parkLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = landmark.name
        
        imageView.image = landmark.image
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        
        let initialLocation = CLLocation(latitude: landmark.localCoordinates.latitude, longitude: landmark.localCoordinates.longitude)
        
        let annotation = LandmarkAnnotation(title: landmark.name, category: landmark.category.rawValue, coordinate: CLLocationCoordinate2D(latitude: landmark.localCoordinates.latitude, longitude: landmark.localCoordinates.longitude))
        
        mapView.addAnnotation(annotation)
        
        mapView.centerToLocation(initialLocation)
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isRotateEnabled = false
        
      
        detailLabel.text = landmark.description
        locationlabel.text = "Location : \(landmark.state), \(landmark.city)"
        categoryLabel.text = "Category : \(landmark.category.rawValue)"
        parkLabel.text = "Park : \(landmark.park)"
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 100000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
