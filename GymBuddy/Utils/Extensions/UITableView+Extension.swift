//
//  UITableView+Extension.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import UIKit

extension UITableView {
    func registerCellType<T: UITableViewCell>(_ type: T.Type) {
        register(UINib(nibName: type.nibName, bundle: nil), forCellReuseIdentifier: type.identifier)
    }

    func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}
