//
//  BaseAPI.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import Foundation
import Combine
import Alamofire

protocol BaseAPI {
    func makeRequest<T: Decodable>(with request: BaseRequest) -> AnyPublisher<T, NetworkError>
}

extension BaseAPI {
//    func makeRequest<T: Decodable>(with request: BaseRequest) -> AnyPublisher<T, NetworkError> {
//        return AF.request(request)
//            .validate()
//            .validate(contentType: [NetworkConstants.ContentType.json])
//            .publishDecodable(type: T.self)
//            .value()
//            .map { response in
//                response.mapError { _ in
//                    let apiError = response.data.flatMap { try? JSONDecoder().decode(APIError.self, from: $0) }
//                    if let apiError {
//                        return NetworkError.systemError(message: apiError.detail)
//                    }
//                    return NetworkError.unknown
//                }
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
    func makeRequest<T: Decodable>(with request: BaseRequest) -> AnyPublisher<T, NetworkError> {
        Future<T, NetworkError> { promise in
            AF.request(request)
                .validate()
                .validate(contentType: [NetworkConstants.ContentType.json])
                .responseDecodable(of: T.self) { response in
                    if let requestURL = response.request?.url?.absoluteString {
                        dLog("Request - \(requestURL)")
                    }
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let error):
                        dLog(error)
                        if let data = response.data,
                           let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                            promise(.failure(.systemError(message: apiError.detail)))
                            return
                        }
                        promise(.failure(.unknown))
                    }
                    
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
