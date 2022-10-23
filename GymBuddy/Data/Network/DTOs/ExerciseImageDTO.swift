//
//  ExerciseImageDTO.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import Foundation

struct ExerciseImageDTO: Decodable {
    let image: String
    let isMain: Bool

    enum CodingKeys: String, CodingKey {
        case image = "image"
        case isMain = "is_main"
    }
}
