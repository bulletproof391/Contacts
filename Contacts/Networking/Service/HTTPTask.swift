//
//  HTTPTask.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 30/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
}
