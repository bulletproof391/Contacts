//
//  ContactsMainTableViewCell.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 29/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

final class ContactsMainCell: UITableViewCell, SetupableCell {

    // MARK: - Outlets

    @IBOutlet private var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet private var emailLabel: UILabel!

    // MARK: - Public properties

    var viewModel: CellViewModel! {
        didSet {
            updateCell()
        }
    }

    // MARK: - Private methods

    private func updateCell() {
        guard let contactsMainCellViewModel = viewModel as? ContactsMainCellViewModel else { return }

        nameLabel.text = contactsMainCellViewModel.name
        emailLabel.text = contactsMainCellViewModel.email
    }
}

final class ContactsMainCellViewModel: CellViewModel, CellViewModelActionable, CellComparing {

    // MARK: - Public properties

    var identifier: String {
        return ContactsMainCell.identifier
    }

    var comparingValue: String {
        return name
    }

    var onTap: ((Int) -> Void)?

    // MARK: - Private properties

    let name: String
    let email: String
    let id: Int?

    // MARK: - Initializers

    init(name: String, email: String, id: Int?) {
        self.name = name
        self.email = email
        self.id = id
    }

    // MARK: - Public methods

    func performAction(at indexPath: IndexPath) {
        guard let id = id else { return }
        onTap?(id)
    }
}
