//
//  ExerciseRequester.swift
//  GymBuddy
//
//  Created by Samir on 10/21/22.
//

import Foundation
import Combine

protocol ExerciseRequester {
    func getListOfExercises() -> AnyPublisher<ExercisesPageDTO, NetworkError>
    func getExerciseDetails(with id: Int) -> AnyPublisher<ExerciseDetailsDTO, NetworkError>
}
