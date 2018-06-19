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
        UINavigationBar.appearance().tintColor = .bokaraGray
        
        // set status background color white
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = .white
        window!.addSubview(statusBarBackgroundView)
        
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusBarBackgroundView.heightAnchor.constraint(equalToConstant: 20),
            statusBarBackgroundView.topAnchor.constraint(equalTo: window!.topAnchor),
            statusBarBackgroundView.leadingAnchor.constraint(equalTo: window!.leadingAnchor),
            statusBarBackgroundView.trailingAnchor.constraint(equalTo: window!.trailingAnchor)])
        
        // clear the title of every backBarButtonItem (remain left arrow)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .highlighted)
        
        return true
    }
}
