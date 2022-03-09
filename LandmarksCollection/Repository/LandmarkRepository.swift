//
//  LandmarkRepository.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import Foundation

class LandmarkRepository {
    static public let shared = LandmarkRepository()
    
    public var landmarks: [Landmark]
    
    init() {
        landmarks = Array()
        do {
            let filPath = Bundle.main.url(forResource: "landmarkData", withExtension: "json")!
            let data = try Data(contentsOf: filPath)
            landmarks = try JSONDecoder().decode([Landmark].self, from: data)
        } catch {
            print("Unable to load data.")
        }
    }
    
    func getLandmarksFeatured() -> [Landmark]{
        return landmarks.filter { landmark in
            landmark.isFeatured
        }
    }
    
    func getLandmarksFavorites() -> [Landmark]{
        return landmarks.filter { landmark in
            landmark.isFavorite
        }
    }
    
    func getLandmarksCategory(category: Landmark.Category) -> [Landmark]{
        return landmarks.filter { landmark in
            landmark.category == category 
        }
    }
}
