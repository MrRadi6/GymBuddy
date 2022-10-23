//
//  ExerciseRequest.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import Foundation
import Alamofire

enum ExerciseRequest: BaseRequest {
    case exercises
    case exercise(id: Int)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .exercises, .exercise:
            return .get
        }
    }
    var path: String {
        switch self {
        case .exercises:
            return Path.exerciseInfo
        case .exercise(let id):
            return Path.exerciseInfo.appending("/\(id)")
        }
    }

    var parameters: Alamofire.Parameters? {
        switch self {
        case .exercises, .exercise:
            return nil
        }
    }
}

extension ExerciseRequest {
    enum Path {
       static let exerciseInfo = "exerciseinfo"
    }
}
