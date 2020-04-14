//
//  AppDelegate.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 14.02.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //MARK: не работает если есть SceneDelegate - и ссылка в Plist
        // подробнее https://stackoverflow.com/questions/58084127/ios-13-swift-set-application-root-view-controller-programmatically-does-not
        
        if Model.shared.loginValue == false {
            
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let homePage = mainStoryboard.instantiateViewController(identifier: "fLoginVC") as! fLoginVC
            self.window?.rootViewController = homePage
    
        }
        
        return true
    }

  


}

