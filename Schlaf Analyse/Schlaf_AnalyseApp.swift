//
//  Schlaf_AnalyseApp.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 22.09.21.
//

import SwiftUI
import HealthKit

@main
struct Schlaf_AnalyseApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            if HKHealthStore.isHealthDataAvailable() {
                
//                GettingStartedWithHealthKit()
                HealthKitAvailableView()
                    .environmentObject(SchlafAnalyseModell())
                
            }
            else {
                HealthKitNotAvailableView()
            }
             
        }
    }
}
