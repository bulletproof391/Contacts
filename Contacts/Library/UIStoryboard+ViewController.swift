//
//  UIStoryboard+ViewController.swift
//  Contacts
//
//  Created by Дмитрий Вашлаев on 30/10/2019.
//  Copyright © 2019 Dmitry Vashlaev. All rights reserved.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        String(describing: self)
    }
}

extension UIStoryboard {
    static func makeViewController<T: UIViewController>(_: T.Type, from storyboard: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(T.self)
    }

    /// Creates ViewController by its Type
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("ViewController \(T.identifier) is not existing."
                + " Please, check .storyboard and ViewController naming")
        }

        return viewController
    }
}
