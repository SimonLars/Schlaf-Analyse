//
//  DurchschnittlicheHerzfrequenz.swift
//  Schlaf Analyse
//
//  Created by Simon Hesse on 30.09.21.
//

import SwiftUI

struct DurchschnittlicheHerzfrequenzView: View {
    
    let durchschnittlicheHerzfrequenz: Int
    
    var body: some View {
        
        Text("Durchschnittliche Herzfrequenz: \(durchschnittlicheHerzfrequenz)")
            .padding()
        
    }
}

struct DurchschnittlicheHerzfrequenz_Previews: PreviewProvider {
    static var previews: some View {
        DurchschnittlicheHerzfrequenzView(durchschnittlicheHerzfrequenz: 56)
    }
}
