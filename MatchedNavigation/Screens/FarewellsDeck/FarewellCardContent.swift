//
//  FarewellCardContent.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct FarewellCardContent: View {
    let farewell: Farewell
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            VStack(alignment: .leading) {
                Text(farewell.title).bold()
                    .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                Text(farewell.description)
                    .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
            }
        }
    }
}

struct FarewellCardContent_Previews: PreviewProvider {
    static var previews: some View {
        FarewellCardContent(farewell: Farewell(title: "bye", description: "..."))
    }
}
