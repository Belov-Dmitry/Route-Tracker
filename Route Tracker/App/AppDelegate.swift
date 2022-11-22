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
        
        GMSServices.provideAPIKey("AIzaSyAnCnoh6dUrPIMq5q3JL2L_X1nAv9S1L5U")
        
        return true
    }

}

