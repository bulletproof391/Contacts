//
//  Router.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 30/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {

    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }
        } catch {
            completion(nil, nil, error)
        }

        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }

    func buildRequest(from route: EndPoint) throws -> URLRequest {

        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: cachePolicy,
                                 timeoutInterval: 10.0)

        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            case let .requestParameters(bodyParameters, urlParameters):
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        request: &request)

            case let .requestParametersAndHeaders(bodyParameters, urlParameters, additionalHeaders):
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        request: &request)
            }

            return request

        } catch {
            throw error
        }
    }

    private func configureParameters(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }

            if let urlParameters = urlParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }

    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
