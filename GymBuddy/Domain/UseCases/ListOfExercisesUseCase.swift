//
//  ListOfExercisesUseCase.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import Foundation
import Combine

protocol ListOfExercisesUseCaseProtocol {
    func getListOfExercises() -> AnyPublisher<[Exercise], AppError>
}

struct ListOfExercisesUseCase: ListOfExercisesUseCaseProtocol {
    let respository: ExerciseRespositoryProtocol

    func getListOfExercises() -> AnyPublisher<[Exercise], AppError> {
        respository.getListOfExercises()
            .mapError { error in
                AppError(message: error.message)
            }
            .eraseToAnyPublisher()
    }
}
