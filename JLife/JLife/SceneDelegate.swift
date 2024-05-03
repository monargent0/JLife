//
//  SceneDelegate.swift
//  JLife
//
//  Created by OoO on 2023/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let mainViewController = MainViewController()
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

