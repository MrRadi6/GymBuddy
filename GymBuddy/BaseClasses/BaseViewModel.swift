//
//  BaseViewModel.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import Combine

class BaseViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var showError: Bool = false

    var appError: AppError? {
        didSet {
            guard appError != nil else { return }
            showError = true
        }
    }
}
