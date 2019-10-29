//
//  ContactsMainTableViewCell.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 29/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

class ContactsMainCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet private var emailLabel: UILabel!

    // MARK: - Cell lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Public methods

    func set(name: String, email: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
}
