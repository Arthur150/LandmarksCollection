//
//  Landmark.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import Foundation

class Landmark: Decodable {
    var name: String
    var category: Category
    var city: String
    var state: String
    var id: Int
    var isFeatured: Bool
    var isFavorite: Bool
    var park: String
    var coordinates: Coordinates
    var description: String
    var imageName: String
    
    
    enum Category: String, Decodable {
        case river = "Rivers"
        case lakes = "Lakes"
        case mountains = "Mountains"
    }
}
