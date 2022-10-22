//
//  UIStoryboard+Extension.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case ListOfExercises

        var fileName: String {
            return rawValue.capitalizedFirstLetter
        }
    }

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.fileName, bundle: bundle)
    }

    func instantiateViewController<T>() -> T where T: StoryboardInstantiable {
        guard let viewController = instantiateViewController(identifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
}
