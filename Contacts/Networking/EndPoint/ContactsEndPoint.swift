//
//  ContactsEndPoint.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 30/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

enum Environment {
    case dev
    case stage
}

enum ContactsApi {
    case users
}

extension ContactsApi: EndPointType {
    var environmentBaseURL: String {
        switch ContactsRequestManager.environment {
        case .dev:
            return "http://jsonplaceholder.typicode.com/"
        case .stage:
            return "http://jsonplaceholder.typicode.com/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }

    var path: String {
        switch self {
        case .users:
            return "users"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .users:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
