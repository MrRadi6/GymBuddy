//
//  ExerciseDetailsViewModel.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import Foundation
import Combine

protocol ExerciseDetailsViewModelProtocol: BaseViewModel {
    var exercideId: Int? { get set }
    var exerciseDetails: ExerciseDetails? { get set }
    
    func loadExerciseDetails()
}

class ExerciseDetailsViewModel: BaseViewModel {

    private let useCase: ExerciseDetailsUseCaseProtocol
    private var storage: Set<AnyCancellable> = []

    @Published var exerciseDetails: ExerciseDetails? = nil
    var exercideId: Int?
    
    init(useCase: ExerciseDetailsUseCaseProtocol) {
        self.useCase = useCase
        super.init()
    }
}

// MARK: - Conforming to ExerciseDetailsViewModelProtocol
extension ExerciseDetailsViewModel: ExerciseDetailsViewModelProtocol {
    func loadExerciseDetails() {
        guard let exercideId else { return }
        isLoading = true
        useCase.getExerciseDetails(with: exercideId).sink { [weak self] completion in
            guard let self else { return }
            self.isLoading = false
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.appError = error
            }
        } receiveValue: { [weak self] exerciseDetails in
            guard let self else { return }
            self.exerciseDetails = exerciseDetails
        }
        .store(in: &storage)
    }
}
