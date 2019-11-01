//
//  ContactsRequestManager.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 30/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

enum Result<String> {
    case success
    case failure(String)
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

typealias GetContactsCompletion = (_ contacts: [ContactResponse]?, _ error: String?) -> Void

protocol ContactsRequesting {
    func getContacts(completion: @escaping GetContactsCompletion)
}

struct ContactsRequestManager: ContactsRequesting {
    static let environment: Environment = .dev
    private let router = Router<ContactsApi>()

    func getContacts(completion: @escaping GetContactsCompletion) {
        router.request(.users) { data, response, error in
            if let connectionError = error as NSError? {
                if connectionError.code == NSURLErrorNotConnectedToInternet {
                    self.router.cachePolicy = .returnCacheDataDontLoad
                    self.getContacts(completion: completion)
                } else {
                    completion(nil, "Something goes wrong")
                }
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }

                    do {
                        let apiResponse = try JSONDecoder().decode([ContactResponse].self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }

                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
