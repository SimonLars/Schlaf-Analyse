//
//  BarChartWithDescription.swift
//  GeometryReader Testen
//
//  Created by Simon Hesse on 28.09.21.
//

import SwiftUI

struct BarChartWithDescription: View {
    
    let data: [Double]
    let dataNames: [String]
    let lineHightInPercent: Double
    
    let totalBarWidth: Double // Between > 0.0 and <= 1.0
    let barChartCornerRadius: Double // Between 0.0 and 1.0
    let barColor: Color
    
    let horizontalLineCornerRadius: Double // Between 0.0 and 1.0
    let lineThickness: Double
    let lineColor: Color
    let lineOpacity: Double // Between 0.0 and 1.0
    
    var body: some View {
        
        GeometryReader{ geometry in
            let screenWidth = geometry.size.width
            let screenHight = geometry.size.height
            
            VStack{
                
                
                
                BarChartWithHorizontalLine(data: data, lineHightInPercent: lineHightInPercent, totalBarWidth: totalBarWidth, barChartCornerRadius: barChartCornerRadius, barColor: barColor, horizontalLineCornerRadius: horizontalLineCornerRadius, lineThickness: lineThickness, lineColor: lineColor, lineOpacity: lineOpacity)
                
                ZStack(alignment: .leading){
                    
                    ForEach(dataNames.indices, id: \.self){ dataNamesIndex in
                        let name = dataNames[dataNamesIndex]
                        
                        Text(name)
                            .offset(x: initialOffset(screenWidth: screenWidth), y: 0)
                            .offset(x: CGFloat(dataNamesIndex) * returnSpaceBetweenTheMiddleOfTwoBars(screenWidth: screenWidth), y: 0)
                        
                    }
                }
            }
        }
    }
    
    func initialOffset(screenWidth: Double) -> CGFloat{
        let spaceBetweenTheMiddleOfTwoBars = returnSpaceBetweenTheMiddleOfTwoBars(screenWidth: screenWidth)
        
        let numberOfBarsToOffset = (Double(dataNames.count) - 1.0) / 2.0
        
        let initialOffset = numberOfBarsToOffset * spaceBetweenTheMiddleOfTwoBars
        
        return initialOffset * -1
    }
    
    func returnSpaceBetweenTheMiddleOfTwoBars(screenWidth: Double) -> CGFloat{
        // answer = one bar + one space
        let totalSpaceForBars = screenWidth * totalBarWidth
        let widthOfOneBar = totalSpaceForBars / Double(dataNames.count)
        
        let totalWidthForSpaces = screenWidth * (1 - totalBarWidth)
        let widthOfOneSpace = totalWidthForSpaces / Double(dataNames.count)
        
        let spaceBetweenTheMiddleOfTwoBars = widthOfOneBar + widthOfOneSpace
        return spaceBetweenTheMiddleOfTwoBars
    }
    
}

struct BarChartWithDescription_Previews: PreviewProvider {
    static var previews: some View {
        BarChartWithDescription(data: [0.5, 0.0, 0.1, 0.9, 1.0, 0.25, 0.75], dataNames: ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"], lineHightInPercent: 0.7, totalBarWidth: 0.7, barChartCornerRadius: 0.5, barColor: .blue, horizontalLineCornerRadius: 1.0, lineThickness: 10, lineColor: .black, lineOpacity: 0.5)
    }
}
