//
//  ContentView.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 22.09.21.
//

import SwiftUI

struct HealthKitAvailableView: View {
    
    @EnvironmentObject var datenModell: SchlafAnalyseModell
    
    var body: some View {
        
        ScrollView{
            
            Text("Health Kit AVAILABLE")

            Button {
                datenModell.erlaubnisFuerSchlafanalyseAnfragen()
            } label: {
                Text("Ask for permission")
            }

            Text(datenModell.userMessage)

            Button("Print Sleep Data"){
                datenModell.storeSleepData(from: DatumHelfer.getDatumMittags(jahr: 2021, monat: 09, tag: 10)!, to: Date())
            }
            
            if datenModell.sleepData.count != 0 {
                
                SchlafChart(data: Normalize.normalize(data: Normalize.getSleepData(data: datenModell.sleepData)), dataNames: ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"], lineHightInPercent: Normalize.normalize(value: 8, to: Normalize.getSleepData(data: datenModell.sleepData).max()!), barChartCornerRadius: 0.5, barColor: .blue, totalBarWidth: 0.7)
            }
            
            Text("Normalized data: \(Normalize.normalize(data: Normalize.getSleepData(data: datenModell.sleepData)).description)")

//            Text("Retrieved Helth Data: \(datenModell.sleepData.description) end")
            
//            Text("retrived Data: \(datenModell.retrievedHealthData)")
            
//            Button("Ask for hear rate reading access"){
//                datenModell.erlaubnisFuerHerzfrequenzAnfragen()
//            }
//            Text("Herzfrequenz verfügbar: \(datenModell.herzfrequenzVerfuegbar ? "true" : "false")")
//
//            Button("Herzfrequenz Daten auslesen"){
//                datenModell.herzfrequenzDatenAuslesen(von: DatumHelfer.getDatumMittags(jahr: 2021, monat: 09, tag: 24)!, bis: Date())
//            }
//
//            Text(datenModell.herzfrequenzDaten)
            
        }
        
    }
}

struct HealthKitAvailableView_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitAvailableView()
            .environmentObject(SchlafAnalyseModell())
    }
}
