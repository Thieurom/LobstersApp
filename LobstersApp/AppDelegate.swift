//
//  AppDelegate.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = window ?? UIWindow()
        window!.backgroundColor = .white
        
        let storiesProvider = StoriesProvider()
        let storiesLoader = StoriesLoader(lobstersService: LobstersService())
        let storiesViewController = StoriesViewController(storiesProvider: storiesProvider, storiesLoader: storiesLoader)
        let navigationController = UINavigationController(rootViewController: storiesViewController)
        
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        // stylize navigation bar
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .white
        
        return true
    }
}
