//
//  ExerciseVariationItem.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import Foundation

struct ExerciseVariationItem: Identifiable {
    let id: String = UUID().uuidString
    let exerciseId: Int
    let name: String
}

extension ExerciseVariationItem {
    init(exercise: Exercise) {
        self.exerciseId = exercise.id
        self.name = exercise.name
    }
}
