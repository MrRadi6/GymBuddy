//
//  ExerciseDTO.swift
//  GymBuddy
//
//  Created by Samir on 10/21/22.
//

import Foundation

struct ExercisesPageDTO: Decodable {
    let results: [ExerciseDTO]
}

struct ExerciseDTO: Decodable {
    let id: Int
    let name: String
    let uuid: String
    let images: [ExerciseImageDTO]
    
    func toDomain() -> Exercise  {
        return Exercise(id: id,
                        name: name,
                        image: images.first(where: { $0.isMain })?.image)
    }
}

struct ExerciseImageDTO: Decodable {
    let image: String
    let isMain: Bool

    enum CodingKeys: String, CodingKey {
        case image = "image"
        case isMain = "is_main"
    }
}
