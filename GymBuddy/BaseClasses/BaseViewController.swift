//
//  BaseViewController.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBInspectable var isLargeTitleEnabled: Bool {
        set {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
        }
        get { return navigationController?.navigationBar.prefersLargeTitles ?? false }
    }
}
