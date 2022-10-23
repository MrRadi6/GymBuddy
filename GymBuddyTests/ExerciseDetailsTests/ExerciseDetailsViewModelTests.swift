//
//  ExerciseDetailsViewModelTests.swift
//  GymBuddyTests
//
//  Created by Samir on 10/23/22.
//

import XCTest
import Combine
@testable import GymBuddy

final class ExerciseDetailsViewModelTests: XCTestCase {
    var sut: ExerciseDetailsViewModel!
    var useCase: ExerciseDetailsUseCaseMock!
    var storage: Set<AnyCancellable> = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        initModule()
    }

    override func tearDown() {
        deinitModule()
        super.tearDown()
    }

    func test_getExerciseDetailsShouldPublishExerciseDetailsWhenExerciseExists() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = ExercisesDataMocks.exerciseDetails
        var result: ExerciseDetails?
        var isLoadingShown = false
        sut.exercideId = expectedResult.id
        sut.$exerciseDetails.sink { exerciseDetails in
            result = exerciseDetails
            expectation.fulfill()
        }
        .store(in: &storage)
        sut.$isLoading.sink { val in
            isLoadingShown = (!isLoadingShown) ? val : false
        }
        .store(in: &storage)
        // When
        sut.loadExerciseDetails()
        useCase.exerciseDetails = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertTrue(isLoadingShown)
        XCTAssertEqual(useCase.getExerciseDetailsCount, 1)
    }

    func test_getExerciseDetailsShouldPublishErrorWhenErrorOccur() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let expectedResult = AppError(message: "an error has occurred")
        var result: AppError?
        sut.exercideId = ExercisesDataMocks.exerciseDetails.id
        sut.$showError.sink(receiveValue: { [weak self] _ in
            guard let self else { return }
            result = self.sut.appError
            expectation.fulfill()
        })
        .store(in: &storage)
        // When
        sut.loadExerciseDetails()
        useCase.error = expectedResult
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expectedResult, result)
        XCTAssertEqual(useCase.getExerciseDetailsCount, 1)
    }
}

// MARK: - Module initialization
extension ExerciseDetailsViewModelTests {
    func initModule() {
        useCase = ExerciseDetailsUseCaseMock()
        sut = ExerciseDetailsViewModel(useCase: useCase)
    }

    func deinitModule() {
        useCase = nil
        sut = nil
        storage.removeAll()
    }
}
