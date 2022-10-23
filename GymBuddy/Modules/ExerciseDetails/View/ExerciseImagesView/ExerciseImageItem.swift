//
//  ExerciseImageItem.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import Foundation

struct ExerciseImageItem: Identifiable {
    let id: String = UUID().uuidString
    let url: String
}
