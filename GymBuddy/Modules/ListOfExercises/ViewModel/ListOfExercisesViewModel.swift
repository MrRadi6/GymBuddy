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
}

class ListOfExercisesViewModel: BaseViewModel {

    private let useCase: ListOfExercisesUseCaseProtocol
    private var storage: Set<AnyCancellable> = []

    @Published var exercises: [Exercise] = []

    init(useCase: ListOfExercisesUseCaseProtocol) {
        self.useCase = useCase
        super.init()
    }
}

// MARK: - Conforming to ListOfExercisesViewModelProtocol
extension ListOfExercisesViewModel: ListOfExercisesViewModelProtocol  {
    var exercisesPublisher: Published<[Exercise]>.Publisher { $exercises }
    
    func loadExercises() {
        isLoading = true
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
