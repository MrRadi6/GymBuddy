//
//  ExerciseDetails.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import Foundation

struct ExerciseDetails {
    let id: Int
    let name: String
    let images: [String]
    let variations: [Exercise]
}

extension ExerciseDetails: Equatable {}
