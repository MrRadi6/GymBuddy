//
//  ListOfExercisesViewController.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import UIKit
import Combine

class ListOfExercisesViewController: UIViewController {

    var viewModel: ListOfExercisesViewModelProtocol!
    private var storage: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadExercises()
        viewModel.exercisesPublisher.sink { exercises in
            print(exercises)
        }.store(in: &storage)
    }
}
