//
//  FarewellDetails.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/16/22.
//

import SwiftUI

struct FarewellDetails: View {
    let farewell: Farewell
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            HStack {
                VStack(alignment: .leading) {
                    Text(farewell.title).bold()
                        .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                    
                    Text(farewell.description)
                        .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.01), radius: 18, x: 0, y: 3)
                    .edgesIgnoringSafeArea([.top, .bottom])
                    .matchedGeometryEffect(id: "Farewells" + farewell.id + "card" + "background", in: namespace)
            )
        }
    }
}

struct FarewellDetails_Previews: PreviewProvider {
    static var previews: some View {
        FarewellDetails(farewell: Farewell(title: "bye", description: "..."))
    }
}
