//
//  ContactDetailsCell.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 29/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

final class ContactDetailsCell: UITableViewCell, SetupableCell {

    // MARK: - Outlets

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    // MARK: - Public properties

    var viewModel: CellViewModel! {
        didSet {
            updateCell()
        }
    }

    // MARK: - Private methods

    private func updateCell() {
        guard let contactDetailsCellViewModel = viewModel as? ContactDetailsCellViewModel else { return }

        titleLabel.text = contactDetailsCellViewModel.title
        descriptionLabel.text = contactDetailsCellViewModel.description
    }
}

final class ContactDetailsCellViewModel: CellViewModel {

    // MARK: - Public properties

    var identifier: String {
        return ContactDetailsCell.identifier
    }

    // MARK: - Private properties

    let title: String
    let description: String

    // MARK: - Initializers

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
