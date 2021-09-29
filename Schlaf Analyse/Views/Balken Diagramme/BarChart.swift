

import SwiftUI

struct BarChart: View {
    
    let data: [Double]
    
    let totalBarWidth: Double // Between 0.2 and 1.0
    let cornerRadius: Double // Between 0.0 and 1.0
    let barColor: Color
    
    
    var body: some View {
        
        GeometryReader{ geometry in
            
            ZStack(alignment: .bottom){
                
                ForEach(data.indices, id: \.self){ dataIndex in
                    let dataPoint = data[dataIndex]
                    let screenWidth = geometry.size.width
                    let sceenHight = geometry.size.height
                    
                    Rectangle()
                        .foregroundColor(barColor)
                        .cornerRadius(cornerRadius / 2 * calculatingWidth(screenWidth: screenWidth))
                        .frame(width: calculatingWidth(screenWidth: screenWidth), height: sceenHight * dataPoint)
                        .offset(x: returnOffset(dataIndex: dataIndex, screenWidth: screenWidth), y: 0)
                }
            }
        }
    }
    
    func calculatingWidth(screenWidth: Double) -> CGFloat{
        let spaceToDivide = screenWidth * totalBarWidth
        let widthOfOneBar = spaceToDivide / Double(data.count)
        return widthOfOneBar
    }
    
    func returnOffset(dataIndex: Int, screenWidth: Double) -> CGFloat{
        let individualSpace = Double(dataIndex) / Double(data.count)
        let firstOffset = individualSpace * screenWidth
        
        let sumOfSpaces = screenWidth * (1 - totalBarWidth)
        let singleSpace = sumOfSpaces / Double(data.count)
        let halfOfSingleSpace = singleSpace / 2
        let secondOffset = halfOfSingleSpace
        
        let totalOffset = firstOffset + secondOffset
        return totalOffset
    }
    
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(data: [0.5, 0.0, 0.1, 0.9, 1.0, 0.25, 0.75], totalBarWidth: 0.7, cornerRadius: 0.5, barColor: .blue)
    }
}
