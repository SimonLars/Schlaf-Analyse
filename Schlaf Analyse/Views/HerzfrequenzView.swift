//
//  DurchschnittlicheHerzfrequenz.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 30.09.21.
//

import SwiftUI

struct HerzfrequenzView: View {
    
    let durchschnittlicheHerzfrequenz: Int
    @EnvironmentObject var herzfrequenz: Herzfrequenz
    
    var body: some View {
        
        VStack{
            
            Text("Durchschnittliche Herzfrequenz: \(durchschnittlicheHerzfrequenz)")
                .padding()
            
            ForEach(herzfrequenz.herzfrequenzen!, id: \.self) { herzfrequenzEintrag in
                
                Text("Herzfrequenz: \(herzfrequenzEintrag.quantity)")
            }
            
        }
        
        
    }
}

struct DurchschnittlicheHerzfrequenz_Previews: PreviewProvider {
    static var previews: some View {
        HerzfrequenzView(durchschnittlicheHerzfrequenz: 56)
    }
}
