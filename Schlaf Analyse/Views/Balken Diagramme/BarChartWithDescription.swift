//
//  BarChartWithDescription.swift
//  GeometryReader Testen
//
//  Created by Simon Hesse on 28.09.21.
//

import SwiftUI

struct BarChartWithDescription: View {
    
    var dataNames: [String] = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
    var barWidth: Double = 0.7
    
    var body: some View {
        
        GeometryReader{ geometry in
            let screenWidth = geometry.size.width
            let screenHight = geometry.size.height
            
            VStack{
                
                BarChartWithHorizontalLine()
                
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
        let totalSpaceForBars = screenWidth * barWidth
        let widthOfOneBar = totalSpaceForBars / Double(dataNames.count)
        
        let totalWidthForSpaces = screenWidth * (1 - barWidth)
        let widthOfOneSpace = totalWidthForSpaces / Double(dataNames.count)
        
        let spaceBetweenTheMiddleOfTwoBars = widthOfOneBar + widthOfOneSpace
        return spaceBetweenTheMiddleOfTwoBars
    }
    
}

struct BarChartWithDescription_Previews: PreviewProvider {
    static var previews: some View {
        BarChartWithDescription()
    }
}
