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
    private var response: [ContactResponse]

    // MARK: - Initializers

    init(requestManager: ContactsRequesting) {
        self.requestManager = requestManager
        self.response = []
    }

    // MARK: - Public methods

    func getContacts(completion: @escaping ([[CellViewModel]]) -> Void) {
        requestManager.getContacts { [weak self] contactsResponse, _ in
            guard let self = self else { return }

            let response = contactsResponse ?? []
            self.response = response

            let viewModels: [CellViewModel] = self.makeViewModels(from: response)

            completion(viewModels.isEmpty ? [] : [viewModels])
        }
    }

    // MARK: - Private methods

    private func makeViewModels(from response: [ContactResponse]) -> [CellViewModel] {
        return response.compactMap {
            let name = $0.name ?? ""
            let email = $0.email ?? ""

            let cellViewModel = ContactsMainCellViewModel(name: name, email: email, id: $0.id)
            cellViewModel.onTap = { id in
                guard let contact = self.response.first(where: {
                    guard let contactId = $0.id else { return false }
                    return contactId == id
                }) else { return }

                let detailsScrenViewModel = ContactDetailsViewModel(contact: contact)
                self.onDetailsScreen?(detailsScrenViewModel)
            }

            return cellViewModel
        }
    }
}
