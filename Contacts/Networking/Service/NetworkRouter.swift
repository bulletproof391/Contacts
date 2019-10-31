//
//  NetworkRouter.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 30/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
