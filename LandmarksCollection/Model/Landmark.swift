//
//  Landmark.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import UIKit
import MapKit

struct Landmark: Decodable, Hashable {
    
    struct Coordinates: Decodable, Hashable {
        let longitude: Double
        let latitude: Double
    }
    
    enum Category: String, CaseIterable, Decodable {
        case river = "Rivers"
        case lakes = "Lakes"
        case mountains = "Mountains"
    }
    
    let name: String
    let category: Category
    let city: String
    let state: String
    let id: Int
    let isFeatured: Bool
    let isFavorite: Bool
    let park: String
    let description: String
    
    private let imageName: String
    private let coordinates: Coordinates
    
    var image: UIImage {
        return UIImage(named: imageName)!
    }
    
    var localCoordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}
