//
//  ContactsMainViewModel.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 31/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import Foundation

final class ContactsMainViewModel {

    // MARK: - Public properties

    var onDetailsScreen: ((ContactDetailsViewModel) -> Void)?

    // MARK: - Private properties

    private let requestManager: ContactsRequesting
    private var sections: [[CellViewModel]]
    private var response: [ContactResponse]

    // MARK: - Initializers

    init(requestManager: ContactsRequesting) {
        self.requestManager = requestManager
        self.sections = []
        self.response = []
    }

    // MARK: - Public methods

    func getContacts(completion: @escaping ([[CellViewModel]]) -> Void) {
        requestManager.getContacts { [weak self] contactsResponse, _ in
            guard let self = self else { return }

            let response = contactsResponse ?? []
            self.response = response

            let viewModels: [CellViewModel] = response.compactMap {
                let name = $0.name ?? ""
                let email = $0.email ?? ""

                let cellViewModel = ContactsMainCellViewModel(name: name, email: email)
                cellViewModel.onTap = { indexPath in
                    guard indexPath.row < self.response.count else { return }

                    let detailsScrenViewModel = ContactDetailsViewModel(contact: self.response[indexPath.row])
                    self.onDetailsScreen?(detailsScrenViewModel)
                }

                return cellViewModel
            }

            self.sections = viewModels.isEmpty ? [] : [viewModels]
            completion(self.sections)
        }
    }
}
