//
//  Normalize.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 29.09.21.
//

import Foundation

struct Normalize {
    
    public static func normalize(data: [Double]) -> [Double] {
        guard data.count != 0 else { return [] }
        let maximumValue = data.max()!
        var normalizedData: [Double] = []
        for value in data {
            let newData = value / maximumValue
            normalizedData.append(newData)
        }
        return normalizedData
    }
    
    public static func normalize(value: Double, toMaximumValue maximumValue: Double) -> Double {
        return value / maximumValue
    }
    
    public static func getSleepData(data: [[Double]]) -> [Double] {
        var newArray: [Double] = []
        for array in data {
            newArray.append(array[0])
        }
        return newArray
    }
}
