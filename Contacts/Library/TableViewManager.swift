//
//  TableViewManager.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 31/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

protocol SetupableCell: UITableViewCell {
    var viewModel: CellViewModel! { get set }
}

protocol CellViewModel {
    var identifier: String { get }
}

protocol CellViewModelActionable {
    func performAction(at indexPath: IndexPath)
}

protocol CellComparing {
    var comparingValue: String { get }
}

protocol TableManager: AnyObject {
    var tableView: UITableView? { get set }
    var sections: [[CellViewModel]] { get }
    func setSections(_ sections: [[CellViewModel]])
    func sort(ascending: Bool)
}

final class BaseTableManager: NSObject, TableManager {
    var sections: [[CellViewModel]] = []
    weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }

    func setSections(_ sections: [[CellViewModel]]) {
        self.sections = sections
        reload()
    }

    func sort(ascending: Bool) {
        sections = sections.map { cellViewModels in
            cellViewModels.sorted { previousCell, nextCell in
                guard let comparablePreviousCell = previousCell as? CellComparing,
                    let comparableNextCell = nextCell as? CellComparing else { return false }

                return ascending
                    ? comparablePreviousCell.comparingValue <= comparableNextCell.comparingValue
                    : comparablePreviousCell.comparingValue >= comparableNextCell.comparingValue
            }
        }

        reload()
    }

    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}

extension BaseTableManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section][indexPath.row].identifier,
                                                 for: indexPath)

        guard let contactsCell = cell as? SetupableCell else { return cell }
        contactsCell.viewModel = sections[indexPath.section][indexPath.row]

        return contactsCell
    }
}

extension BaseTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cellViewModel = sections[indexPath.section][indexPath.row] as? CellViewModelActionable else {
            return
        }
        cellViewModel.performAction(at: indexPath)
    }
}
