//
//  DatumHelfer.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 24.09.21.
//

import Foundation

struct DatumHelfer {
    
    public static func getDatum(jahr: Int, monat: Int, tag: Int, stunde: Int, minute: Int, sekunde: Int) -> Date? {
        
        var datumsKomponenten = DateComponents()
        datumsKomponenten.year = jahr
        datumsKomponenten.month = monat
        datumsKomponenten.day = tag
        datumsKomponenten.hour = stunde
        datumsKomponenten.minute = minute
        datumsKomponenten.second = sekunde
        
        let aktuellerKalender = Calendar.current
        let gesuchtesDatum = aktuellerKalender.date(from: datumsKomponenten)
        return gesuchtesDatum
        
    }
    
    public static func getDatumMittags(jahr: Int, monat: Int, tag: Int) -> Date? {
        
        var datumsKomponenten = DateComponents()
        datumsKomponenten.year = jahr
        datumsKomponenten.month = monat
        datumsKomponenten.day = tag
        datumsKomponenten.hour = 12
        datumsKomponenten.minute = 0
        datumsKomponenten.second = 0
        
        let aktuellerKalender = Calendar.current
        let gesuchtesDatum = aktuellerKalender.date(from: datumsKomponenten)
        return gesuchtesDatum
        
    }
    
    public static func datumFormatieren(datum: Date) -> String {
        
        let kalender = Calendar.current
        let komponenten = kalender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: datum)
        
        let formatierterString = "\(komponenten.day!).\(komponenten.month!).\(komponenten.year!) \(komponenten.hour!):\(komponenten.minute!):\(komponenten.second!)"
        return formatierterString
    }
    
}
