//
//  ListOfExercisesViewModelTests.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import XCTest
import Combine
@testable import GymBuddy

final class ListOfExercisesViewModelTests: XCTestCase {

    var sut: ListOfExercisesViewModel!
    var useCase: ListOfExercisesUseCaseMock!
    var storage: Set<AnyCancellable> = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        initModule()
    }

    override func tearDown() {
        deinitModule()
        super.tearDown()
    }

    func test_loadExercisesShouldPublishExercisesWhenExercisesExists() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = [ExercisesDataMocks.excerciseOne,
                               ExercisesDataMocks.excerciseTwo,
                               ExercisesDataMocks.excerciseThree]
        var result: [Exercise]?
        var isLoadingShown = false
        sut.exercisesPublisher.sink { exercises in
            result = exercises
            expectation.fulfill()
        }
        .store(in: &storage)
        sut.$isLoading.sink { val in
            isLoadingShown = (!isLoadingShown) ? val : false
        }
        .store(in: &storage)
        // When
        sut.loadExercises()
        useCase.exercises = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertTrue(isLoadingShown)
        XCTAssertEqual(useCase.getListOfExercisesCount, 1)
    }

    func test_loadExercisesShouldPublishErrorWhenErrorOccur() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = AppError(message: "an error has occurred")
        var result: AppError?
        sut.$showError.sink(receiveValue: { [weak self] _ in
            guard let self else { return }
            result = self.sut.appError
            expectation.fulfill()
        })
        .store(in: &storage)
        // When
        sut.loadExercises()
        useCase.error = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertEqual(useCase.getListOfExercisesCount, 1)
    }

    func test_reloadExercisesShouldPublishExercisesWhenExercisesExists() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = [ExercisesDataMocks.excerciseOne,
                               ExercisesDataMocks.excerciseTwo,
                               ExercisesDataMocks.excerciseThree]
        var result: [Exercise]?
        var isLoadingShown = false
        sut.exercisesPublisher.sink { exercises in
            result = exercises
            expectation.fulfill()
        }
        .store(in: &storage)
        sut.$isLoading.sink { val in
            isLoadingShown = (!isLoadingShown) ? val : false
        }
        .store(in: &storage)
        // When
        sut.reloadExercises()
        useCase.exercises = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertFalse(isLoadingShown)
        XCTAssertEqual(useCase.getListOfExercisesCount, 1)
    }

    func test_reloadExercisesShouldPublishErrorWhenErrorOccur() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = AppError(message: "an error has occurred")
        var result: AppError?
        sut.$showError.sink(receiveValue: { [weak self] _ in
            guard let self else { return }
            result = self.sut.appError
            expectation.fulfill()
        })
        .store(in: &storage)
        // When
        sut.reloadExercises()
        useCase.error = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertEqual(useCase.getListOfExercisesCount, 1)
    }
}

// MARK: - Module initialization
extension ListOfExercisesViewModelTests {

    func initModule() {
        useCase = ListOfExercisesUseCaseMock()
        sut = ListOfExercisesViewModel(useCase: useCase)
    }

    func deinitModule() {
        useCase = nil
        sut = nil
        storage.removeAll()
    }
}
