//
//  ExerciseRespositoryMock.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import Foundation
import Combine
@testable import GymBuddy

class ExerciseRespositoryMock: ExerciseRespositoryProtocol {

    private var publisher: PassthroughSubject<Any, NetworkError> = PassthroughSubject()

    var getListOfExercisesCount = 0
    var getExerciseDetailsCount = 0

    var exercises: [Exercise] = [] {
        didSet { publisher.send(exercises) }
    }

    var exerciseDetails: ExerciseDetails? {
        didSet {
            guard let exerciseDetails else { return }
            publisher.send(exerciseDetails)
        }
    }

    var error: NetworkError? {
        didSet {
            guard let error else { return }
            publisher.send(completion: .failure(error))
        }
    }

    func getListOfExercises() -> AnyPublisher<[Exercise], NetworkError> {
        getListOfExercisesCount += 1
        return publisher
            .map { $0 as! [Exercise] }
            .eraseToAnyPublisher()
    }

    func getExerciseDetails(with id: Int) -> AnyPublisher<ExerciseDetails, NetworkError> {
        getExerciseDetailsCount += 1
        return publisher
            .map { $0 as! ExerciseDetails }
            .eraseToAnyPublisher()
    }
}
