//
//  ContactsResponse.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 30/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

struct ContactResponse: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?

    struct Address: Decodable {
        let street: String?
        let suite: String?
        let city: String?
    }

    struct Company: Decodable {
        let name: String?
    }
}
