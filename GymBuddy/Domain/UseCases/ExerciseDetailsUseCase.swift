//
//  ExerciseDetailsUseCase.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import Foundation
import Combine

protocol ExerciseDetailsUseCaseProtocol {
    func getExerciseDetails(with id: Int) -> AnyPublisher<ExerciseDetails, AppError>
}

struct ExerciseDetailsUseCase: ExerciseDetailsUseCaseProtocol {
    let respository: ExerciseRespositoryProtocol

    func getExerciseDetails(with id: Int) -> AnyPublisher<ExerciseDetails, AppError> {
        respository.getExerciseDetails(with: id)
            .mapError({ AppError(message: $0.message )})
            .eraseToAnyPublisher()
    }
}
