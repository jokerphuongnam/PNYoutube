//
//  MainNavigationCordinator.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation
import SwiftUI

final class MainNavigationCordinator: NSObject, ObservableObject {
    @Published var path = NavigationPath()
}
