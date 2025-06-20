//
//  SceneDelegate.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 20.06.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let todoRouter = TodoListRouter.start()
        guard let vc = todoRouter.entry else {return}
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = UINavigationController(rootViewController: vc)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

