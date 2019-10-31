//
//  UIView+Reflection.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 31/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
