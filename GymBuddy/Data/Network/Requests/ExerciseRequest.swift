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

    var method: Alamofire.HTTPMethod {
        switch self {
        case .exercises: return .get
        }
    }
    var path: String {
        switch self {
        case .exercises: return Path.exerciseInfo
        }
    }

    var parameters: Alamofire.Parameters? {
        switch self {
        case .exercises: return nil
        }
    }
}

extension ExerciseRequest {
    enum Path {
       static let exerciseInfo = "exerciseinfo"
    }
}
