//
//  ListOfExercisesViewModel.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import Foundation
import Combine

protocol ListOfExercisesViewModelProtocol: BaseViewModel {
    var exercisesPublisher: Published<[Exercise]>.Publisher { get }
    func loadExercises()
    func reloadExercises()
    func getExcerciseId(at index: Int) -> Int
}

class ListOfExercisesViewModel: BaseViewModel {

    private let useCase: ListOfExercisesUseCaseProtocol
    private var storage: Set<AnyCancellable> = []

    @Published var exercises: [Exercise] = []

    var exercisesPublisher: Published<[Exercise]>.Publisher { $exercises }

    init(useCase: ListOfExercisesUseCaseProtocol) {
        self.useCase = useCase
        super.init()
    }

    private func getExercises(showLoading: Bool) {
        isLoading = true && showLoading
        useCase.getListOfExercises()
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.appError = error
                }
            } receiveValue: { exercises in
                self.exercises = exercises
            }
            .store(in: &storage)
    }
}

// MARK: - Conforming to ListOfExercisesViewModelProtocol
extension ListOfExercisesViewModel: ListOfExercisesViewModelProtocol  {
    
    func loadExercises() {
        getExercises(showLoading: true)
    }

    func reloadExercises() {
        getExercises(showLoading: false)
    }

    func getExcerciseId(at index: Int) -> Int {
        exercises[index].id
    }
}
