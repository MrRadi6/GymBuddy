//
//  AppError.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import Foundation

struct AppError: Error {
    var title: String?
    var message: String
}

extension AppError: Equatable {}
