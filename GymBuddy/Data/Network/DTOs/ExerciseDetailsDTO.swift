//
//  ExerciseDetailsDTO.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import Foundation

struct ExerciseDetailsDTO: Decodable {
    let id: Int
    let name: String
    let uuid: String
    let images: [ExerciseImageDTO]
    let variations: [Int]
}
