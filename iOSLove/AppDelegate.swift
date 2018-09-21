//
//  AppDelegate.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/28/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit
import BrightFutures

@UIApplicationMain
internal final class AppDelegate: UIResponder {
    var window: UIWindow?
    private var coordinator: Coordinator?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window
        
        let coordinator = MainCoordinator(window: window)
        self.coordinator = coordinator
        
        coordinator.start()
        
        return true
    }
}


