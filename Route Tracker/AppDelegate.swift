//
//  AppDelegate.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 25.10.2022.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AddAPIKeyHere")
        
        return true
    }
}

