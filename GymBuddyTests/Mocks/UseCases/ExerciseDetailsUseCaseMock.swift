//
//  ExerciseDetailsUseCaseMock.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import Foundation
import Combine
@testable import GymBuddy

class ExerciseDetailsUseCaseMock: ExerciseDetailsUseCaseProtocol {

    private var publisher: PassthroughSubject<ExerciseDetails, AppError> = PassthroughSubject()

    var getExerciseDetailsCount = 0

    var exerciseDetails: ExerciseDetails? {
        didSet {
            guard let exerciseDetails else { return }
            publisher.send(exerciseDetails)
        }
    }
    var error: AppError? {
        didSet {
            guard let error else { return }
            publisher.send(completion: .failure(error))
        }
    }

    func getExerciseDetails(with id: Int) -> AnyPublisher<ExerciseDetails, AppError> {
        getExerciseDetailsCount += 1
        return publisher.eraseToAnyPublisher()
    }
}
