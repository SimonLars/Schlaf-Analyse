//
//  Rechner.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 25.09.21.
//

import Foundation
import HealthKit

struct Rechner {
    
    private static let heartRateUnit: HKUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
    
    public static func durchschnittlicheHerzfrequenz(herzfrequenzen: [HKQuantitySample]) -> Double {
        
        var summe: Double = 0
        
        for element in herzfrequenzen {
            if element.quantityType == HKObjectType.quantityType(forIdentifier: .heartRate){
                
                summe += element.quantity.doubleValue(for: heartRateUnit)
            }
        }
        
        let durchschnittlicheHerzfrequenz = summe / Double(herzfrequenzen.count)
        return durchschnittlicheHerzfrequenz
        
    }
    
    public static func niedrigsteHerzfrequenz(herzfrequenzen: [HKQuantitySample]) -> Double {
        
        guard herzfrequenzen.count != 0 else { return -1.0 }
        
        var niedrigsteHerzfrequenz = herzfrequenzen[0]
        
        for herzfrequenz in herzfrequenzen {
            if herzfrequenz.quantity.doubleValue(for: heartRateUnit) < niedrigsteHerzfrequenz.quantity.doubleValue(for: heartRateUnit) {
                niedrigsteHerzfrequenz = herzfrequenz
            }
        }
        return niedrigsteHerzfrequenz.quantity.doubleValue(for: heartRateUnit)
    }
    
    public static func durchschnittlicheAbweichungHerzfrequenz(herzfrequenzen: [HKQuantitySample]) -> Double? { // Standardabweichung ist die durchschnittliche Abweichung
        
        guard herzfrequenzen.count != 0 else { return nil }
        
        // Berechnung des Durchschnittes
        let durchschnittlicheHerzfrequenz: Double = durchschnittlicheHerzfrequenz(herzfrequenzen: herzfrequenzen)
        
        // Berechnung der Summe der Abweichungen
        var summeDerAbweichungen: Double = 0.0
        for herzefrequenz in herzfrequenzen {
            summeDerAbweichungen += abs(durchschnittlicheHerzfrequenz - herzefrequenz.quantity.doubleValue(for: heartRateUnit))
        }
        
        // Teilen der gesamten Abweichungen durch die Anzahl der Einträge = Standardabweichung
        let durchschnittlicheAbweichung: Double = summeDerAbweichungen / Double(herzfrequenzen.count)
        return durchschnittlicheAbweichung
    }
    
}
