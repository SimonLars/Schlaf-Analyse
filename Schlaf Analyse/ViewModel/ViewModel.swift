//
//  DatenModell.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 22.09.21.
//

import Foundation
import HealthKit

class ViewModel: ObservableObject {
    
    let healthStore = HKHealthStore()
    @Published var schlaf: Schlaf
    @Published var herzfrequenz: Herzfrequenz
    
    init() {
        schlaf = Schlaf(healthStore: healthStore)
        herzfrequenz = Herzfrequenz(healthStore: healthStore)
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Schlaf Analyse -
//    @Published var sleepData: [[Double]] = []
    
    
//    public func erlaubnisFuerSchlafanalyseAnfragen() {
//        let dataToRequest = Set([HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!])
//        healthKitStore.requestAuthorization(toShare: nil, read: dataToRequest) { (success, error) in
//            DispatchQueue.main.async{
//                if success {
//                    self.storeSleepDataForLast7Days()
//                } else {
//                    print(error?.localizedDescription)
//                }
//            }
//        }
//    }
//
//    private func storeSleepDataForLast7Days() {
//        let currentDate = Date()
//        let date7DaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
//        storeSleepData(from: date7DaysAgo, to: currentDate)
//    }
//
//    public func storeSleepData(from startDate: Date, to endDate: Date) {
//        sleepData = []
//        let startDateMittags = DatumHelfer.getDatumMittags(datum: startDate)!
//        let endDateMittags = DatumHelfer.getDatumMittags(datum: endDate)!
//        let numberOfDays = DatumHelfer.numberOfDaysBetween(startDate: startDateMittags, endDate: endDateMittags)
//
//        for index in 0...numberOfDays - 1 {
//            let anfang: Date = startDateMittags + (Double(index) * 86400.0)
//            let ende: Date = startDateMittags + (Double(index + 1) * 86400.0)
//            retrieveSleepData(von: anfang, bis: ende)
//        }
//    }
//    private func retrieveSleepData(von anfangsDatum: Date, bis endDatum: Date) {
//        let typSchlafAnalyse = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
//        let zeitraum = HKQuery.predicateForSamples(withStart: anfangsDatum, end: endDatum, options: .strictStartDate)
//        let sortierung = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//
//        let anfrage = HKSampleQuery(sampleType: typSchlafAnalyse, predicate: zeitraum, limit: 10000, sortDescriptors: [sortierung]) { (query, result, error) in
//            if error != nil { return }
//            if let result = result {
//                let categorySampleResult = result.compactMap({ $0 as? HKCategorySample}) // Converts [HKSample] to [HKCategorySample]
//                var totalSleepInSeconds: Double = 0.0
//                var totalBedTimeInSeconds: Double = 0.0
//                for eintrag in categorySampleResult {
//                    guard let schlafWert = HKCategoryValueSleepAnalysis(rawValue: eintrag.value) else { return }
//                    let timeIntervalInSeconds = eintrag.endDate.timeIntervalSince(eintrag.startDate)
//                    switch schlafWert {
//                    case .asleep:
//                        totalSleepInSeconds += timeIntervalInSeconds
//                    case .awake,
//                         .inBed:
//                        totalBedTimeInSeconds += timeIntervalInSeconds
//                    default:
//                        break
//                    }
//                }
//                DispatchQueue.main.async {
//                    self.sleepData.append([totalSleepInSeconds / 60 / 60, totalBedTimeInSeconds / 60 / 60])
//                }
//            }
//        }
//        healthKitStore.execute(anfrage)
//    }
    
    // MARK: - Herzfrequenz -
    
//    @Published var herzfrequenzVerfuegbar: Bool = false
//    @Published var herzfrequenzDaten: String = ""
//    @Published var durchschnittlicheHerzfrequenz: Int?
//
//    public func erlaubnisFuerHerzfrequenzAnfragen() {
//        let nachgefragteDaten = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
//        healthKitStore.requestAuthorization(toShare: nil, read: nachgefragteDaten) { success, error in
//            DispatchQueue.main.async {
//                if success {
//                    self.herzfrequenzVerfuegbar = true
//                    self.herzfrequenzDatenFuerLetzten7TageSpeichern()
//                } else {
//                    self.herzfrequenzVerfuegbar = false
//                }
//            }
//        }
//    }
//    private func herzfrequenzDatenFuerLetzten7TageSpeichern() {
//        let aktuellesDatum = Date()
//        let datumVor7Tagen = Calendar.current.date(byAdding: .day, value: -7, to: aktuellesDatum)!
//        herzfrequenzDatenAuslesen(von: datumVor7Tagen, bis: aktuellesDatum)
//    }
//    public func herzfrequenzDatenAuslesen(von startDatum: Date, bis endDatum: Date) {
//        let typHerzfrequenz = HKObjectType.quantityType(forIdentifier: .heartRate)!
//        let zeitraum = HKQuery.predicateForSamples(withStart: startDatum, end: endDatum, options: .strictStartDate)
//        let sortierung = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//        let anfrage = HKSampleQuery.init(sampleType: typHerzfrequenz, predicate: zeitraum, limit: 5, sortDescriptors: [sortierung]) { sampleQuery, sample, error in
//            if error != nil { return }
//            if let ausgepacktesSample = sample {
//                let quantitySample = ausgepacktesSample.compactMap({ $0 as? HKQuantitySample}) // Converts [HKSample] to [HKQuantitySample]
//                let durchschnittlicheHerzfrequenz = Rechner.durchschnittlicheHerzfrequenz(herzfrequenzen: quantitySample)
//                let niedrigsteHerzfrequenz = Rechner.niedrigsteHerzfrequenz(herzfrequenzen: quantitySample)
//                let durchschnittlicheAbweichung = Rechner.durchschnittlicheAbweichungHerzfrequenz(herzfrequenzen: quantitySample)
//                for element in quantitySample {
//                    if element.quantityType == HKObjectType.quantityType(forIdentifier: .heartRate){
//                        DispatchQueue.main.async {
//                            self.herzfrequenzDaten += "quantity: \(element.quantity) \ncount \(element.count) \nquantityType: \(element.quantityType)\nstartDate: \(element.startDate)\nendDate: \(element.endDate)\n\n"
//                        }
//                    }
//                }
//                DispatchQueue.main.async {
//                    self.herzfrequenzDaten += "Durchschnittliche Herzfrequenz: \(durchschnittlicheHerzfrequenz)\n"
//                    self.durchschnittlicheHerzfrequenz = Int(durchschnittlicheHerzfrequenz)
//                    self.herzfrequenzDaten += "Niedrigste Herzfrequenz: \(Int(niedrigsteHerzfrequenz))\n"
//                    self.herzfrequenzDaten += "Standardabweichung: \(durchschnittlicheAbweichung!)"
//                }
//            }
//        }
//        healthKitStore.execute(anfrage)
//    }
}
