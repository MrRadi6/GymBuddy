//
//  ApplicationFlow.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//
import UIKit

class ApplicationFlow {

    var window: UIWindow?

    static var shared = ApplicationFlow()

    func launchApp() {
        let listOfExercisesView = ListOfExercisesNavigator.createModule()
        let navigationController = UINavigationController(rootViewController: listOfExercisesView)
        setRootView(navigationController)
    }

    private func setRootView(_ viewController: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
