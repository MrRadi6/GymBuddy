//
//  ExerciseDataMocks.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import Foundation
@testable import GymBuddy

enum ExercisesDataMocks {
    static let excerciseOne = Exercise(id: 1, name: "Exercise one", image: "https://image1.apple.com")
    static let excerciseTwo = Exercise(id: 2, name: "Exercise two", image: "https://image2.apple.com")
    static let excerciseThree = Exercise(id: 3, name: "Exercise three", image: "https://image3.apple.com")

    static let exerciseDetails = ExerciseDetails(id: 1,
                                                 name: "Exercise one",
                                                 images: ["https://image1.apple.com"],
                                                 variations: [excerciseTwo, excerciseThree])
}
