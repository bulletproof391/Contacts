//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 29/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

final class ContactDetailsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(with: ContactDetailsCell.identifier)
            tableView.allowsSelection = false
            tableManager.tableView = tableView
        }
    }

    // MARK: - Public properties

    var viewModel: ContactDetailsViewModel!

    // MARK: - Private properties

    private let tableManager: TableManager = BaseTableManager()

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableManager.setSections(viewModel.sections)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
}
