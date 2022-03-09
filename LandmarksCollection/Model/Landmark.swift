//
//  Landmark.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import Foundation

class Landmark: Codable {
    var name: String
    var category: String
    var city: String
    var state: String
    var id: Int
    var isFeatured: Bool
    var isFavorite: Bool
    var park: String
    var coordinate: Coordinate
    var description: String
    var imageName: String
    
}
