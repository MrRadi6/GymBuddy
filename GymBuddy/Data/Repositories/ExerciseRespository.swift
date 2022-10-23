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
    func getExerciseDetails(with id: Int) -> AnyPublisher<ExerciseDetails, NetworkError>
}

struct ExerciseRespository: ExerciseRespositoryProtocol {

    let remote: ExerciseRequester

    func getListOfExercises() -> AnyPublisher<[Exercise], NetworkError> {
        remote.getListOfExercises()
            .map({ $0.results.map{( $0.toDomain() )} })
            .eraseToAnyPublisher()
    }

    func getExerciseDetails(with id: Int) -> AnyPublisher<ExerciseDetails, NetworkError> {
        remote.getExerciseDetails(with: id)
            .flatMap { exerciseDTO in
                Publishers.MergeMany(exerciseDTO.variations
                    .filter({ $0 != exerciseDTO.id })
                    .map { remote.getExerciseDetails(with: $0)}
                )
                .collect()
                .map { variationsDTO in
                    let variations = variationsDTO.map({ Exercise(id: $0.id, name: $0.name )})
                    let images = exerciseDTO.images.map({ $0.image })
                    return ExerciseDetails(id: exerciseDTO.id, name: exerciseDTO.name, images: images, variations: variations)
                }
            }.eraseToAnyPublisher()
    }
}
