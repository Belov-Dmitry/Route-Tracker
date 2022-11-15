//
//  SceneDelegate.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 25.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var visualEffectView = UIVisualEffectView(effect: nil)
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        self.visualEffectView.removeFromSuperview()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        if !self.visualEffectView.isDescendant(of: self.window!) {
            let blurEffect = UIBlurEffect(style: .light)
            self.visualEffectView = UIVisualEffectView(effect: blurEffect)
            self.visualEffectView.frame = (self.window?.bounds)!
            self.window?.addSubview(self.visualEffectView)
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        self.visualEffectView.removeFromSuperview()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
}
