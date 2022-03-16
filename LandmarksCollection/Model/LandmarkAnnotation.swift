//
//  LandmarkAnnotation.swift
//  LandmarksCollection
//
//  Created by lpiem on 16/03/2022.
//

import MapKit

class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let category: String?
    
    let coordinate: CLLocationCoordinate2D
    
    init(title:String?,category:String?,coordinate:CLLocationCoordinate2D){
        self.title = title
        self.category = category
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return category
    }
    
}
