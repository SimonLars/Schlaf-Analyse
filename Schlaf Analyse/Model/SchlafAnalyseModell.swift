//
//  DatenModell.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 22.09.21.
//

import Foundation
import HealthKit

class SchlafAnalyseModell: ObservableObject {
    
    // MARK: - Schlaf Analyse -
    @Published var userMessage = ""
    @Published var retrievedHealthData = ""
    
    let healthKitStore = HKHealthStore()
    
    public func erlaubnisFuerSchlafanalyseAnfragen() {
        
        let dataToRequest = Set([HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!])
        
        healthKitStore.requestAuthorization(toShare: nil, read: dataToRequest) { (success, error) in
            
            DispatchQueue.main.async{
                if success {
                    self.userMessage = "Erfolgreiche Erlaubnis auf Health Store"
                }
                else {
                    self.userMessage = error!.localizedDescription
                }
            }
            
        }
    }
    
    public func retrieveSleepData(von anfangsDatum: Date, bis endDatum: Date) {
        
        let typSchlafAnalyse = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let zeitraum = HKQuery.predicateForSamples(withStart: anfangsDatum, end: endDatum, options: .strictStartDate)
        let sortierung = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let anfrage = HKSampleQuery(sampleType: typSchlafAnalyse, predicate: zeitraum, limit: 10000, sortDescriptors: [sortierung]) { (query, result, error) in
            if error != nil { return }
            
            if let result = result {
                
                let categorySampleResult = result.compactMap({ $0 as? HKCategorySample}) // Converts [HKSample] to [HKCategorySample]
                
                for eintrag in categorySampleResult {
                    
                    guard let schlafWert = HKCategoryValueSleepAnalysis(rawValue: eintrag.value) else { return }
                    
                    var schlafzustand = ""
                    
                    switch schlafWert {
                    case .asleep:
                        schlafzustand = "schlafend"
                    case .awake,
                         .inBed:
                        schlafzustand = "wach"
                    default:
                        schlafzustand = ""
                    }
                    
                    DispatchQueue.main.async {
                        self.retrievedHealthData += "\n"
                        self.retrievedHealthData += "Schlafwert: \(schlafzustand) (\(schlafWert.rawValue)) ||| Startzeit: \(DatumHelfer.datumFormatieren(datum: eintrag.startDate)) ||| Endzeit: \(DatumHelfer.datumFormatieren(datum: eintrag.endDate)) ||| Quelle: \(eintrag.sourceRevision.source.name)"
                        self.retrievedHealthData += "\n"
                    }
                }
            }
        }
        healthKitStore.execute(anfrage)
    }
    
    // MARK: - Herzfrequenz -
    
    @Published var herzfrequenzVerfuegbar: Bool = false
    @Published var herzfrequenzDaten = ""
    
    public func erlaubnisFuerHerzfrequenzAnfragen() {
        let nachgefragteDaten = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        
        healthKitStore.requestAuthorization(toShare: nil, read: nachgefragteDaten) { success, error in
            DispatchQueue.main.async {
                if success {
                    self.herzfrequenzVerfuegbar = true
                }
                else {
                    self.herzfrequenzVerfuegbar = false
                }
            }
        }
    }
    
    public func herzfrequenzDatenAuslesen(von startDatum: Date, bis endDatum: Date) {
        
        let typHerzfrequenz = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let zeitraum = HKQuery.predicateForSamples(withStart: startDatum, end: endDatum, options: .strictStartDate)
        let sortierung = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        
        let anfrage = HKSampleQuery.init(sampleType: typHerzfrequenz, predicate: zeitraum, limit: 5, sortDescriptors: [sortierung]) { sampleQuery, sample, error in
            if error != nil { return }
            
            if let ausgepacktesSample = sample {
                
                let quantitySample = ausgepacktesSample.compactMap({ $0 as? HKQuantitySample}) // Converts [HKSample] to [HKQuantitySample]
                
                let durchschnittlicheHerzfrequenz = Rechner.durchschnittlicheHerzfrequenz(herzfrequenzen: quantitySample)
                let niedrigsteHerzfrequenz = Rechner.niedrigsteHerzfrequenz(herzfrequenzen: quantitySample)
                let durchschnittlicheAbweichung = Rechner.durchschnittlicheAbweichungHerzfrequenz(herzfrequenzen: quantitySample)
                
                for element in quantitySample {
                    
                    if element.quantityType == HKObjectType.quantityType(forIdentifier: .heartRate){
                        
                        DispatchQueue.main.async {
                            self.herzfrequenzDaten += "quantity: \(element.quantity) \ncount \(element.count) \nquantityType: \(element.quantityType)\nstartDate: \(element.startDate)\nendDate: \(element.endDate)\n\n"
                        }
                        
                    }
                    
                }
                DispatchQueue.main.async {
                    self.herzfrequenzDaten += "Durchschnittliche Herzfrequenz: \(durchschnittlicheHerzfrequenz)\n"
                    self.herzfrequenzDaten += "Niedrigste Herzfrequenz: \(Int(niedrigsteHerzfrequenz))\n"
                    self.herzfrequenzDaten += "Standardabweichung: \(durchschnittlicheAbweichung!)"
                }
            }
            
            
        }
        
        healthKitStore.execute(anfrage)
        
    }
    
}


