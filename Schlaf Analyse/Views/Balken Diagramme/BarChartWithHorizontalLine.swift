

import SwiftUI

struct BarChartWithHorizontalLine: View {
    
    var lineHightInPercent: Double = 0.7 // Betrwenn 0.0 and 1.0
    var cornerRadius: Double = 1.0 // Between 0.0 and 1.0
    var lineThickness: Double = 10.0
    var lineColor: Color = .black
    var opacity: Double = 0.5 // Between 0.0 and 1.0
    
    var body: some View {
        
        GeometryReader{ geometry in
            let screenWidth = geometry.size.width
            let screenHight = geometry.size.height
            
            ZStack{
                
                BarChart()
                
                Rectangle()
                    .foregroundColor(lineColor)
                    .frame(width: screenWidth, height: lineThickness)
                    .cornerRadius(returnCornerRadius())
                    .opacity(opacity)
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
        return cornerRadius / 2.0 * lineThickness
    }
}

struct BarChartWithHorizontalLine_Previews: PreviewProvider {
    static var previews: some View {
        BarChartWithHorizontalLine()
    }
}
