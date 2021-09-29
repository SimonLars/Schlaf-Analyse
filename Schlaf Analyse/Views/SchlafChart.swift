//
//  SchlafChart.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 28.09.21.
//

import SwiftUI

struct SchlafChart: View {
    
    var data: [Double] = [0.5, 0.3, 0.1, 0.9, 1.0, 0.25, 0.75]
    var dataNames: [String] = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
    var barWidth: Double = 0.7
    
    // Bar Chart:
    var barChartCornerRadius: Double = 0.5 // Between 0.0 and 1.0
    let barColor: Color = .blue
    var totalBarWidth: Double = 0.7 // Between > 0.0 and <= 1.0
    
    
    var body: some View {
        
        GeometryReader{ geometry in
            let screenWidth: CGFloat = geometry.size.width
            let screenHight: CGFloat = geometry.size.height
            
            BarChartWithDescription(data: data, dataNames: dataNames, lineHightInPercent: 0.7, totalBarWidth: 0.7, barChartCornerRadius: 0.3, barColor: .blue, horizontalLineCornerRadius: 1.0, lineThickness: 7, lineColor: .black, lineOpacity: 0.5)
                .frame(width: screenWidth * 0.9, height: screenHight * 0.4)
                .padding(.leading, screenWidth * 0.05)
            
        }
        
    }
}

struct SchlafChart_Previews: PreviewProvider {
    static var previews: some View {
        SchlafChart()
    }
}
