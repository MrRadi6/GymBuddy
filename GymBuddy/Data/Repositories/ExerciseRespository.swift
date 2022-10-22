//
//  ExerciseRespository.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import Foundation
import Combine

protocol ExerciseRespositoryProtocol {
    func getListOfExercises() -> AnyPublisher<[Exercise], NetworkError>
}

struct ExerciseRespository: ExerciseRespositoryProtocol {
    let remote: ExerciseRequester

    func getListOfExercises() -> AnyPublisher<[Exercise], NetworkError> {
        remote.getListOfExercises()
            .map({ $0.results.map{( $0.toDomain() )} })
            .eraseToAnyPublisher()
    }
}
