//
//  ViewController.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 29/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

class ContactsMainViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView! {
        didSet {
            let identifier = String(describing: ContactsMainCell.self)
            tableView.register(UINib(nibName: identifier, bundle: nil),
                               forCellReuseIdentifier: identifier)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()

        let requestManager = ContactsRequestManager()
        requestManager.getContacts { response, errorString in
            print(response)
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
        barButtonItem.tintColor = UIColor(red: 75 / 255, green: 0, blue: 130 / 255, alpha: 1)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func sortItems() {

    }

}

extension ContactsMainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ContactsMainCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath)

        guard let contactsCell = cell as? ContactsMainCell else { return cell}
        contactsCell.set(name: "asd\nxcv", email: "weq@qwe.com")

        return contactsCell
    }
}

extension ContactsMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let contactDetailsViewController = UIStoryboard.makeViewController(ContactDetailsViewController.self,
                                                                           from: GlobalConstants.Storyboard.main)
        navigationController?.pushViewController(contactDetailsViewController, animated: true)
    }
}

private extension ContactsMainViewController {
    enum Constant {
        static let title = "Contacts"
    }
}
