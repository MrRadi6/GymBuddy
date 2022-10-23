//
//  ExerciseDetailsNavigator.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import SwiftUI

struct ExerciseDetailsNavigator {
    static func createModule(with id: Int) -> ExerciseDetailsView {
        let remoteApi = ExerciseAPI()
        let repository = ExerciseRespository(remote: remoteApi)
        let useCase = ExerciseDetailsUseCase(respository: repository)
        let viewModel = ExerciseDetailsViewModel(useCase: useCase)
        let view = ExerciseDetailsView(viewModel: viewModel)
        return view
    }
}
