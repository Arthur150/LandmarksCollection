//
//  LandmarkRepository.swift
//  LandmarksCollection
//
//  Created by lpiem on 09/03/2022.
//

import Foundation

class LandmarkRepository {
    static public let shared = LandmarkRepository()
    
    func loadLandmarks() -> [Landmark] {
        var landmarks: [Landmark] = Array()
        do {
            let filPath = Bundle.main.url(forResource: "landmarkData", withExtension: "json")!
            let data = try Data(contentsOf: filPath)
            landmarks = try JSONDecoder().decode([Landmark].self, from: data)
        } catch {
            print("Unable to load data.")
        }
        return landmarks
    }
}
