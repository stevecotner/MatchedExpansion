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
                HStack {
                    Text(farewell.title).bold()
//                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }
                .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                
                HStack {
                    Text(farewell.description)
                    Spacer(minLength: 0)
                }
                    .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
            }
            .matchedGeometryEffect(id: "farewells" + "cardcontent" + farewell.id, in: namespace)
        }
    }
}

struct FarewellCardContent_Previews: PreviewProvider {
    static var previews: some View {
        FarewellCardContent(
            farewell: Farewell(
                title: "bye",
                description: "...",
                details: "..."
            )
        )
    }
}
