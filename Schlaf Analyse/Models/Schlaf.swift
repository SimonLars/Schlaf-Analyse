//
//  Schlaf.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 30.09.21.
//

import Foundation
import HealthKit

class Schlaf: ObservableObject {
    
    @Published var datenSchlafend: [Double]?
    @Published var datenImBett: [Double]?
    let healthStore: HKHealthStore
    
    init(healthStore: HKHealthStore){
        self.healthStore = healthStore
        self.leseZugriffFragen()
    }
    
    // Konstanten
    private let schlafAnalyseTyp = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
    private let sekundenInEinemTag = 86400.0
    
    public func leseZugriffFragen() {
        let schlafAnalyse = Set([schlafAnalyseTyp])
        healthStore.requestAuthorization(toShare: nil, read: schlafAnalyse) { erfolg, fehler in
            if erfolg {
                self.datenLadenLetzte(tage: 7)
            }
        }
    }
    
    public func datenLadenLetzte(tage: Int) {
        let aktuellesDatum = Date()
        let datumVorXTagen = Calendar.current.date(byAdding: .day, value: -1 * tage, to: aktuellesDatum)!
        datenLaden(von: datumVorXTagen, bis: aktuellesDatum)
    }
    
    public func datenLaden(von startDatum: Date, bis endDatum: Date) {
        datenSchlafend = []
        datenImBett = []
        let startDatumMittags = DatumHelfer.getDatumMittags(datum: startDatum)!
        let endDatumMittags = DatumHelfer.getDatumMittags(datum: endDatum)!
        let anzahlAnTagen = DatumHelfer.numberOfDaysBetween(startDate: startDatumMittags, endDate: endDatumMittags)
        for index in 0...anzahlAnTagen - 1 {
            let anfang = startDatumMittags + (Double(index) * sekundenInEinemTag)
            let ende = startDatumMittags + (Double(index + 1) * sekundenInEinemTag)
            datenLadenProTag(von: anfang, bis: ende)
        }
    }
    
    private func datenLadenProTag(von startDatum: Date, bis endDatum: Date) {
        let zeitraum = HKQuery.predicateForSamples(withStart: startDatum, end: endDatum, options: .strictStartDate)
        let sortierung = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 84400
        
        let anfrage = HKSampleQuery(sampleType: schlafAnalyseTyp, predicate: zeitraum, limit: limit, sortDescriptors: [sortierung]) { anfrage, hkSampleDaten, fehler in
            if fehler != nil { return }
            if let daten = hkSampleDaten {
                let hkKetegorieDaten = daten.compactMap( { $0 as? HKCategorySample }) // Von [HKSample] zu [HKCategorySample]
                var gesamtSchlafInSekunden: Double = 0.0
                var gesamtZeitImBettInSekunden: Double = 0.0
                for eintrag in hkKetegorieDaten {
                    guard let schlafEintrag = HKCategoryValueSleepAnalysis(rawValue: eintrag.value) else { return }
                    let zeitIntervallInSekunden = eintrag.endDate.timeIntervalSince(eintrag.startDate)
                    switch schlafEintrag {
                    case .asleep:
                        gesamtSchlafInSekunden += zeitIntervallInSekunden
                    case .awake,
                         .inBed:
                        gesamtZeitImBettInSekunden += zeitIntervallInSekunden
                    default:
                        break
                    }
                }
                DispatchQueue.main.async {
                    if self.datenSchlafend == nil {
                        self.datenSchlafend = []
                    }
                    if self.datenImBett == nil {
                        self.datenImBett = []
                    }
                    self.datenSchlafend?.append(gesamtSchlafInSekunden)
                    self.datenImBett?.append(gesamtZeitImBettInSekunden)
                    print("Schlaf daten Laden: \(self.datenSchlafend) ")
                }
            }
        }
        healthStore.execute(anfrage)
    }
    
}
