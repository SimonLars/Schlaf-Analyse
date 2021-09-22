//
//  Schlaf_AnalyseApp.swift
//  Schlaf Analyse WatchKit Extension
//
//  Created by Simon Hesse on 22.09.21.
//

import SwiftUI

@main
struct Schlaf_AnalyseApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
