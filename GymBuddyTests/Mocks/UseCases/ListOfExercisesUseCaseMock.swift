//
//  ListOfExercisesUseCaseMock.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import Foundation
import Combine
@testable import GymBuddy

class ListOfExercisesUseCaseMock: ListOfExercisesUseCaseProtocol {

    private var publisher: PassthroughSubject<[Exercise], AppError> = PassthroughSubject()

    var getListOfExercisesCount = 0

    var exercises: [Exercise] = [] {
        didSet { publisher.send(exercises) }
    }
    var error: AppError? {
        didSet {
            guard let error else { return }
            publisher.send(completion: .failure(error))
        }
    }

    func getListOfExercises() -> AnyPublisher<[Exercise], AppError> {
        getListOfExercisesCount += 1
        return publisher.eraseToAnyPublisher()
    }
}
