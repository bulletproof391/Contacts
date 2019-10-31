//
//  ContactDetailsViewModel.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 31/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

final class ContactDetailsViewModel {

    // MARK: - Public properties

    private(set) var sections: [[CellViewModel]]

    // MARK: - Initializers

    init(contact: ContactResponse) {
        self.sections = []

        let cells = makeCells(from: contact)
        sections = cells.isEmpty ? [] : [cells]
    }

    // MARK: - Public methods

    private func makeCells(from contact: ContactResponse) -> [CellViewModel] {
        var cellViewModels: [CellViewModel] = []

        if let userName = contact.username {
            cellViewModels.append(ContactDetailsCellViewModel(title: userName,
                                                              description: Constant.userName))
        }

        if let phone = contact.phone {
            cellViewModels.append(ContactDetailsCellViewModel(title: phone,
                                                              description: Constant.phone))
        }

        if let suite = contact.address?.suite,
            let street = contact.address?.street,
            let city = contact.address?.city {

            let address = "\(suite), \(street), \(city)"
            cellViewModels.append(ContactDetailsCellViewModel(title: address,
                                                              description: Constant.address))
        }

        if let website = contact.website {
            cellViewModels.append(ContactDetailsCellViewModel(title: website,
                                                              description: Constant.website))
        }

        if let companyName = contact.company?.name {
            cellViewModels.append(ContactDetailsCellViewModel(title: companyName,
                                                              description: Constant.companyName))
        }

        return cellViewModels
    }
}

private extension ContactDetailsViewModel {
    enum Constant {
        static let userName = "Username"
        static let phone = "Phone"
        static let address = "Address"
        static let website = "Website"
        static let companyName = "Company name"
    }
}
