//
//  BaseRequest.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import Foundation
import Alamofire

protocol BaseRequest: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

extension BaseRequest {

    func asURLRequest() throws -> URLRequest {
        let url = try HostService.baseUrl.asURL()
        let version = HostService.version
        var urlRequest = URLRequest(url: url.appendingPathComponent("api")
            .appendingPathComponent(version)
            .appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        urlRequest.headers = getHTTPHeaders()
        var encoding: ParameterEncoding

        if let parameters = parameters {
            if method == .get {
                encoding = URLEncoding.default
            } else {
                encoding = JSONEncoding.default
            }
            do {
                urlRequest = try encoding.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }

    private func getHTTPHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = HTTPHeaders()
        headers.add(.contentType(NetworkConstants.ContentType.json))
        headers.add(.accept(NetworkConstants.ContentType.json))
        return headers
    }
}
