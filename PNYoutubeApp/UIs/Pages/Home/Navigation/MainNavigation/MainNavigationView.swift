//
//  MainNavigationView.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import SwiftUI

struct MainNavigationView: View {
    @StateObject fileprivate var coordinator: MainNavigationCordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView.create(viewModel: HomeViewModel(useCase: PNAppDelegate.resolve()))
        }
    }
}

extension MainNavigationView {
    static func create(coordinator: MainNavigationCordinator) -> MainNavigationView {
        Self(coordinator: coordinator)
    }
}

#Preview {
    MainNavigationView(coordinator: MainNavigationCordinator())
}
