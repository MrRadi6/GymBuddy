//
//  ListOfExercisesUseCaseTests.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import XCTest
import Combine
@testable import GymBuddy

final class ListOfExercisesUseCaseTests: XCTestCase {
    var sut: ListOfExercisesUseCase!
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

    func test_getListOfExercisesShouldPublishExercisesWhenExercisesExists() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = [ExercisesDataMocks.excerciseOne,
                               ExercisesDataMocks.excerciseTwo,
                               ExercisesDataMocks.excerciseThree]
        let publisher = sut.getListOfExercises()
        var result: [Exercise]?

        publisher.sink { _ in
            expectation.fulfill()
        } receiveValue: { exercises in
            result = exercises
            expectation.fulfill()
        }
        .store(in: &storage)
        // When
        repository.exercises = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertEqual(repository.getListOfExercisesCount, 1)
    }

    func test_getListOfExercisesShouldPublishErrorWhenErrorOccur() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = AppError(message: NetworkError.unknown.message)
        let publisher = sut.getListOfExercises()
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
        XCTAssertEqual(repository.getListOfExercisesCount, 1)
    }
}

// MARK: - Module initialization
extension ListOfExercisesUseCaseTests {

    func initModule() {
        repository = ExerciseRespositoryMock()
        sut = ListOfExercisesUseCase(respository: repository)
    }

    func deinitModule() {
        repository = nil
        sut = nil
        storage.removeAll()
    }
}
