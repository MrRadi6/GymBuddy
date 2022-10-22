//
//  UIViewController+Extension.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import UIKit

extension UIViewController: StoryboardInstantiable {}

extension UIViewController {
    func showErrorMessage(title: String?, error: String) {
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "global_alert_ok".localized, style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

