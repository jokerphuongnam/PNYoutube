//
//  MainView.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import SwiftUI

struct MainView: View {
    @State fileprivate var state: MainTabState = .home
    
    var body: some View {
        TabView(selection: $state) {
            MainNavigationView.create(coordinator: MainNavigationCordinator())
        }
    }
    
    @ViewBuilder private var mainView: some View {
        MainNavigationView.create(coordinator: MainNavigationCordinator())
    }
}

#Preview {
    MainView()
}
