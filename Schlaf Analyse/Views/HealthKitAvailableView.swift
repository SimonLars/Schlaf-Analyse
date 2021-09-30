//
//  ContentView.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 22.09.21.
//

import SwiftUI

struct HealthKitAvailableView: View {
    
    @EnvironmentObject var schlaf: Schlaf
    @EnvironmentObject var herzfrequenz: Herzfrequenz
    
    var body: some View {
        
        ScrollView{

            if schlaf.datenSchlafend != nil && schlaf.datenSchlafend?.count != 0 {
                
                SchlafChart(data: Normalize.normalize(data: schlaf.datenSchlafend!), dataNames: ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"], lineHightInPercent: Normalize.normalize(value: 8.0 * 60 * 60, toMaximumValue: (schlaf.datenSchlafend?.max()!)!), barChartCornerRadius: 0.5, barColor: .blue, totalBarWidth: 0.7)
                
            }
            if herzfrequenz.durchschnittlicheHerzfrequenz != nil {
                HerzfrequenzView(durchschnittlicheHerzfrequenz: herzfrequenz.durchschnittlicheHerzfrequenz!)
                    .onAppear {
                        HerzfrequenzRechner.durchschnittlicheHerzfrequenzNachZeit(herzfrequenzen: herzfrequenz.herzfrequenzen!) 
                    }
            }
            if (schlaf.datenSchlafend == nil || schlaf.datenSchlafend!.count == 0 ) && herzfrequenz.durchschnittlicheHerzfrequenz == nil {
                Text("Loading")
            }
        
        }
    }
}

//struct HealthKitAvailableView_Previews: PreviewProvider {
//    static var previews: some View {
//        HealthKitAvailableView()
//            .environmentObject(ViewModel())
//    }
//}
