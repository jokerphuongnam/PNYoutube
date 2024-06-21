//
//  PNAppDelegate.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import UIKit

final class PNAppDelegate: NSObject, UIApplicationDelegate {
    private static var container = diRegister()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    static func resolve<T>() -> T {
        container.resolve(T.self)!
    }
    
    static func resolve<T>(name: String) -> T {
        container.resolve(T.self, name: name)!
    }
}
