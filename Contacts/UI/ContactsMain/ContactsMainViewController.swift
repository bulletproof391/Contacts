//
//  ViewController.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 29/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

final class ContactsMainViewController: UIViewController {
    typealias OnDetailsScreen = (ContactDetailsViewModel) -> Void

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(with: ContactsMainCell.identifier)
            tableManager.tableView = tableView
        }
    }

    // MARK: - Private properties

    private let tableManager: TableManager = BaseTableManager()
    private let viewModel = ContactsMainViewModel(requestManager: ContactsRequestManager())
    private lazy var onDetailsScreen: OnDetailsScreen? = { [weak self] detailsScreenViewModel in
        self?.showDetailsController(detailsScreenViewModel)
    }

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()

        viewModel.onDetailsScreen = onDetailsScreen
        viewModel.getContacts { [weak self] sections in
            self?.tableManager.setSections(sections)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }

    // MARK: - Private methods

    private func setupViewController() {
        title = Constant.title

        let barButtonItem = UIBarButtonItem(image: UIImage(named: GlobalConstants.Images.icSort),
                                            style: .plain,
                                            target: self,
                                            action: #selector(sortItems))
        barButtonItem.tintColor = Constant.barButtonColor
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func sortItems() {

    }

    private func showDetailsController(_ detailsScreenViewModel: ContactDetailsViewModel) {
        let contactDetailsViewController = UIStoryboard.makeViewController(ContactDetailsViewController.self,
                                                                           from: GlobalConstants.Storyboard.main)

        contactDetailsViewController.viewModel = detailsScreenViewModel
        navigationController?.pushViewController(contactDetailsViewController, animated: true)
    }
}

private extension ContactsMainViewController {
    enum Constant {
        static let title = "Contacts"
        static let barButtonColor = UIColor(red: 75 / 255, green: 0, blue: 130 / 255, alpha: 1)
    }
}
