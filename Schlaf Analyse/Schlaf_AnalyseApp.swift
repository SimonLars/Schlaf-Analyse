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
    
    @State var healthStore = HKHealthStore()
    
    var body: some Scene {
        
        WindowGroup {
            
            if HKHealthStore.isHealthDataAvailable() {
                
                HealthKitAvailableView()
                    .environmentObject(Schlaf(healthStore: healthStore))
                    .environmentObject(Herzfrequenz(healthStore: healthStore))
                    
            }
            else {
                HealthKitNotAvailableView()
            }
             
        }
    }
}
