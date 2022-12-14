//
//  NetworkError.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import Foundation

struct APIError: Decodable {
    let detail: String
}


enum NetworkError: Error {
    case api(message: String)
    case unknown

    var message: String {
        switch self {
        case .api(let message):
            return message
        case .unknown:
            return "global_unkown_network_error".localized
        }
    }
}
