

import SwiftUI

struct BarChartWithHorizontalLine: View {
    
    let data: [Double]
    let lineHightInPercent: Double // Betrwenn 0.0 and 1.0
    
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
            
            ZStack{
                
                BarChart(data: data, totalBarWidth: totalBarWidth, cornerRadius: barChartCornerRadius, barColor: barColor)
                
                Rectangle()
                    .foregroundColor(lineColor)
                    .frame(width: screenWidth, height: lineThickness)
                    .cornerRadius(returnCornerRadius())
                    .opacity(lineOpacity)
                    .offset(x: 0, y: screenHight / 2) // Offset to the bottom
                    .offset(x: 0, y: offsetForLineHight(screenHight: screenHight))
            }
            
        }
        
    }
    
    func offsetForLineHight(screenHight: Double) -> CGFloat {
        let offsetForLineHight = screenHight * lineHightInPercent
        return offsetForLineHight * -1
    }
    
    func returnCornerRadius() -> CGFloat {
        return horizontalLineCornerRadius / 2.0 * lineThickness
    }
}

struct BarChartWithHorizontalLine_Previews: PreviewProvider {
    static var previews: some View {
        BarChartWithHorizontalLine(data: [0.5, 0.0, 0.1, 0.9, 1.0, 0.25, 0.75], lineHightInPercent: 0.7, totalBarWidth: 0.7, barChartCornerRadius: 0.5, barColor: .blue, horizontalLineCornerRadius: 1.0, lineThickness: 10, lineColor: .black, lineOpacity: 0.5)
    }
}
