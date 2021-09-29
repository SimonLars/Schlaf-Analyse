//
//  SchlafChart.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 28.09.21.
//

import SwiftUI

struct SchlafChart: View {
    
    let data: [Double]
    let dataNames: [String]
    let lineHightInPercent: Double
    
    // Bar Chart:
    var barChartCornerRadius: Double // Between 0.0 and 1.0
    let barColor: Color
    var totalBarWidth: Double // Between > 0.0 and <= 1.0
    
    var body: some View {
        
        VStack{
            
                let screenWidth: CGFloat = UIScreen.main.bounds.size.width
                let screenHight: CGFloat = UIScreen.main.bounds.size.height
                
                BarChartWithDescription(data: data, dataNames: dataNames, lineHightInPercent: lineHightInPercent, totalBarWidth: 0.7, barChartCornerRadius: 0.3, barColor: .blue, horizontalLineCornerRadius: 1.0, lineThickness: 7, lineColor: .black, lineOpacity: 0.5)
                    .frame(width: screenWidth * 0.9, height: screenHight * 0.4)
                
            Text("Text in View")
        }
        
    }
}

struct SchlafChart_Previews: PreviewProvider {
    static var previews: some View {
        SchlafChart(data: [0.5, 0.3, 0.1, 0.9, 1.0, 0.25, 0.75], dataNames: ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"], lineHightInPercent: 0.75, barChartCornerRadius: 0.5, barColor: .blue, totalBarWidth: 0.7)
    }
}
