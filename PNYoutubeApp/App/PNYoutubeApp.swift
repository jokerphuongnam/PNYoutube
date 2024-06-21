//
//  PNYoutubeApp.swift
//  PNYoutubeApp
//
//  Created by P. Nam on 18/06/2024.
//

import SwiftUI
import SwiftData

@main
struct PNYoutubeApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: PNAppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
