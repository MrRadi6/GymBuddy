//
//  BaseAPI.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import Foundation
import Combine
import Alamofire

protocol NetworkClient {
    func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor?) -> DataRequest
}
protocol BaseAPI {
    var networkClient: NetworkClient { get set }
    func makeRequest<T: Decodable>(with request: BaseRequest) -> AnyPublisher<T, NetworkError>
}

extension BaseAPI {
    func makeRequest<T: Decodable>(with request: BaseRequest) -> AnyPublisher<T, NetworkError> {
        Future<T, NetworkError> { promise in
            networkClient.request(request, interceptor: nil)
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
                            promise(.failure(.api(message: apiError.detail)))
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

extension Session: NetworkClient {}
