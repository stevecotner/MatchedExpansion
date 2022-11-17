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
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(farewell.title)
                        Spacer(minLength: 0)
                    }
                    .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                    .font(.system(size: 18, weight: .semibold))
                    
                    HStack {
                        Text(farewell.description)
                        Spacer(minLength: 0)
                    }
                    .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
                    .font(.system(size: 16.36, weight: .regular))
                }
                
                Spacer()
                Image(farewell.imageName ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "farewells" + "image" + farewell.id, in: namespace)
                    .frame(width: 55, height: 55)
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
