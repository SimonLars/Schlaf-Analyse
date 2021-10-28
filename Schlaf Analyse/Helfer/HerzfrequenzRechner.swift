
import Foundation
import HealthKit

struct HerzfrequenzRechner {
    
    public static let heartRateUnit: HKUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
    
    public static func sekundenInStunden(sekunden: Double) -> Double {
        let stunden = sekunden / 60 / 60
        return stunden
    }
    
    public static func durchschnittlicheHerzfrequenz(herzfrequenzen: [HKQuantitySample]) -> Int {
        let sortierteHerzfrequenzen = herzfrequenzen.sorted(by: { $0.startDate < $1.startDate })
        
        let startDatum = sortierteHerzfrequenzen.first!.startDate
        let endDatum = sortierteHerzfrequenzen.last!.endDate
        let totalTimeInterval = endDatum.timeIntervalSince(startDatum)
        
        var summe: Double = 0
        
        for index in 0..<sortierteHerzfrequenzen.count - 1 {
            let timeInterval = sortierteHerzfrequenzen[index + 1].startDate.timeIntervalSince(sortierteHerzfrequenzen[index].startDate)
            summe += sortierteHerzfrequenzen[index].quantity.doubleValue(for: heartRateUnit) * timeInterval
        }
        let durchschnittlicheHerzfrequenz = summe / totalTimeInterval
        let gerundeteDurchschnittlicheHerzfrequenz = Int(round(durchschnittlicheHerzfrequenz))
        return gerundeteDurchschnittlicheHerzfrequenz
    }
    
    public static func niedrigsteHerzfrequenz(herzfrequenzen: [HKQuantitySample]) -> Int? {
        guard herzfrequenzen.count != 0 else { return nil }
        let niedrigsteHerzfrequenz = herzfrequenzen.min(by: { $0.quantity.doubleValue(for: heartRateUnit) < $1.quantity.doubleValue(for: heartRateUnit) })
        return Int(round(niedrigsteHerzfrequenz!.quantity.doubleValue(for: heartRateUnit)))
    }
    public static func hoechsteHerzfrequenz(herzfrequenzen: [HKQuantitySample]) -> Int? {
        guard herzfrequenzen.count != 0 else { return nil }
        let hoechsteHerzfrequenz = herzfrequenzen.max(by: { $0.quantity.doubleValue(for: heartRateUnit) > $1.quantity.doubleValue(for: heartRateUnit) })
        return Int(round(hoechsteHerzfrequenz!.quantity.doubleValue(for: heartRateUnit)))
    }
    
    public static func durchschnittlicheAbweichungHerzfrequenz(herzfrequenzen: [HKQuantitySample]) -> Double? { // Standardabweichung ist die durchschnittliche Abweichung
        
        guard herzfrequenzen.count != 0 else { return nil }
        
        // Berechnung des Durchschnittes
        let durchschnittlicheHerzfrequenz: Double = Double(durchschnittlicheHerzfrequenz(herzfrequenzen: herzfrequenzen))
        
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
