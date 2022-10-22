//
//  SceneDelegate.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        ApplicationFlow.shared.window = window
        ApplicationFlow.shared.launchApp()
    }
}

