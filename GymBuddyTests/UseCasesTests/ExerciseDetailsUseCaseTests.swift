//
//  ExerciseDetailsUseCaseTests.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import XCTest
import Combine
@testable import GymBuddy

final class ExerciseDetailsUseCaseTests: XCTestCase {
    var sut: ExerciseDetailsUseCase!
    var repository: ExerciseRespositoryMock!
    var storage: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        initModule()
    }

    override func tearDown() {
        deinitModule()
        super.tearDown()
    }

    func test_getExerciseDetailsShouldPublishExerciseDetailsWhenExercisesExists() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = ExercisesDataMocks.exerciseDetails
        let publisher = sut.getExerciseDetails(with: ExercisesDataMocks.exerciseDetails.id)
        var result: ExerciseDetails?

        publisher.sink { _ in
            expectation.fulfill()
        } receiveValue: { exercises in
            result = exercises
            expectation.fulfill()
        }
        .store(in: &storage)
        // When
        repository.exerciseDetails = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertEqual(repository.getExerciseDetailsCount, 1)
    }

    func test_getExerciseDetailsShouldPublishErrorWhenErrorOccur() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = AppError(message: NetworkError.unknown.message)
        let publisher = sut.getExerciseDetails(with: ExercisesDataMocks.exerciseDetails.id)
        var result: AppError?

        publisher.sink { completion in
            switch completion {
            case.finished:
                break
            case .failure(let error):
                result = error
            }
            expectation.fulfill()
        } receiveValue: { _ in
            expectation.fulfill()
        }
        .store(in: &storage)
        // When
        repository.error = NetworkError.unknown
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertEqual(repository.getExerciseDetailsCount, 1)
    }

}

// MARK: - Module initialization
extension ExerciseDetailsUseCaseTests {

    func initModule() {
        repository = ExerciseRespositoryMock()
        sut = ExerciseDetailsUseCase(respository: repository)
    }

    func deinitModule() {
        repository = nil
        sut = nil
        storage.removeAll()
    }
}
