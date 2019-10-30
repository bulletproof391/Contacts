//
//  ContactDetailsCell.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 29/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

class ContactDetailsCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

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

    func set(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
