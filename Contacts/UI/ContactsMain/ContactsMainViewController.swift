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
    private let loaderView = LoaderView()
    private lazy var onDetailsScreen: OnDetailsScreen? = { [weak self] detailsScreenViewModel in
        self?.showDetailsController(detailsScreenViewModel)
    }

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        getContacts()
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        view.addSubview(loaderView)
        loaderView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    private func getContacts() {
        handle(isLoading: true)

        viewModel.onDetailsScreen = onDetailsScreen
        viewModel.getContacts { [weak self] sections in
            self?.handle(isLoading: false)
            self?.tableManager.setSections(sections)
        }
    }

    @objc private func sortItems() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Sort by A-Z", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.tableManager.sort(ascending: true)
        })

        alert.addAction(UIAlertAction(title: "Sort by Z-A", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.tableManager.sort(ascending: false)
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        })

        present(alert, animated: true)
    }

    private func handle(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.loaderView.startAnimating()
                self?.tableView.isHidden = true
            } else {
                self?.loaderView.stopAnimating()
                self?.tableView.isHidden = false
            }
        }
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
