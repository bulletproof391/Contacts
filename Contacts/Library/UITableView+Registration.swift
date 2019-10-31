//
//  UITableView+Registration.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 31/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

extension UITableView {
    func register(with identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil),
                           forCellReuseIdentifier: identifier)
    }
}
