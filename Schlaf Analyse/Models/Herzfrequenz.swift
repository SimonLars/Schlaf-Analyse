//
//  Herzfrequenz.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 30.09.21.
//

import Foundation
import HealthKit

class Herzfrequenz: ObservableObject {
    
    @Published var herzfrequenzen: [HKQuantitySample]? {
        didSet{
            if herzfrequenzen?.count != 0 && herzfrequenzen != nil {
                durchschnittlicheHerzfrequenz = HerzfrequenzRechner.durchschnittlicheHerzfrequenz(herzfrequenzen: herzfrequenzen!)
                niedrigsteHerzfrequenz = HerzfrequenzRechner.niedrigsteHerzfrequenz(herzfrequenzen: herzfrequenzen!)
                hoechsteHerzfrequenz = HerzfrequenzRechner.hoechsteHerzfrequenz(herzfrequenzen: herzfrequenzen!)
            }
        }
    }
    @Published var durchschnittlicheHerzfrequenz: Int?
    @Published var niedrigsteHerzfrequenz: Int?
    @Published var hoechsteHerzfrequenz: Int?
    let healthStore: HKHealthStore
    
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        self.leseZugriffFragen()
    }
    
    // Konstanten
    private let herzfrequenzTyp = HKObjectType.quantityType(forIdentifier: .heartRate)!
    private let herzfrequenzEinheit: HKUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
    
    public func leseZugriffFragen() {
        let herzfrequenz = Set([herzfrequenzTyp])
        healthStore.requestAuthorization(toShare: nil, read: herzfrequenz) { erfolg, fehler in
            if erfolg {
                self.datenLadenLetzte(tage: 1)
            }
        }
    }
    
    public func datenLadenLetzte(tage: Int) {
        let aktuellesDatum = Date()
        let datumVorXTagen = Calendar.current.date(byAdding: .day, value: -1 * tage, to: aktuellesDatum)!
        datenLaden(von: datumVorXTagen, bis: aktuellesDatum)
    }
    
    public func datenLaden(von startDatum: Date, bis endDatum: Date) {
        let zeitraum = HKQuery.predicateForSamples(withStart: startDatum, end: endDatum, options: .strictStartDate)
        let sortierung = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 84400
        
        let anfrage = HKSampleQuery.init(sampleType: herzfrequenzTyp, predicate: zeitraum, limit: limit, sortDescriptors: [sortierung]) { anfrage, hkSampleDaten, fehler in
            if fehler != nil { return }
            if let daten = hkSampleDaten {
                let hkQuantitySample = daten.compactMap({ $0 as? HKQuantitySample }) // Von [HKSample] zu [HKQuantitySample]
                DispatchQueue.main.async {
                    self.herzfrequenzen = hkQuantitySample
                }
            }
        }
        healthStore.execute(anfrage)
    }
    
}
