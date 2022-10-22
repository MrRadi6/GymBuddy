//
//  ExerciseAPI.swift
//  GymBuddy
//
//  Created by Samir on 10/21/22.
//

import Foundation
import Combine

struct ExerciseAPI: ExerciseRequester {
    func getListOfExercises() -> AnyPublisher<ExercisesPageDTO, NetworkError> {
        makeRequest(with: ExerciseRequest.exercises)
    }
}

extension ExerciseAPI: BaseAPI {}
