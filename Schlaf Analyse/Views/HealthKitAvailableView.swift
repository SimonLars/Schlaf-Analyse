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
                datenModell.retrieveSleepData(von: DatumHelfer.getDatumMittags(jahr: 2021, monat: 09, tag: 28) ?? Date(), bis: Date())
            }

            Text("retrived Data: \(datenModell.retrievedHealthData)")
            
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
