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
    private var publisher: PassthroughSubject<[Exercise], NetworkError> = PassthroughSubject()

    var getListOfExercisesCount = 0

    var exercises: [Exercise] = [] {
        didSet { publisher.send(exercises) }
    }

    var error: NetworkError? {
        didSet {
            guard let error else { return }
            publisher.send(completion: .failure(error))
        }
    }

    func getListOfExercises() -> AnyPublisher<[Exercise], NetworkError> {
        getListOfExercisesCount += 1
        return publisher.eraseToAnyPublisher()
    }
}
