//
//  ListOfExercisesNavigator.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import Foundation

struct ListOfExercisesNavigator {

    static func createModule() -> ListOfExercisesViewController {
        let remoteAPI = ExerciseAPI()
        let repository = ExerciseRespository(remote: remoteAPI)
        let useCase = ListOfExercisesUseCase(respository: repository)
        let viewModel = ListOfExercisesViewModel(useCase: useCase)
        let view = ListOfExercisesViewController.instantiate(from: .ListOfExercises)
        view.viewModel = viewModel
        return view
    }
}
