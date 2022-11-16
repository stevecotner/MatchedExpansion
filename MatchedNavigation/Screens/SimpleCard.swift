//
//  Card.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct SimpleCard: View {
    /// used for matchedGeometryEffect
    let id: String
    let title: String
    let description: String
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            VStack {
                Text(title).bold()
                    .matchedGeometryEffect(id: id + "cardtitle", in: namespace)
                Text(description)
                    .matchedGeometryEffect(id: id + "carddescription", in: namespace)
            }
            .padding(.horizontal, 20)
            .padding(.top, 22)
            .padding(.bottom, 24)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .shadow(color: .black.opacity(0.2), radius: 18, x: 0, y: 3)
                    .matchedGeometryEffect(id: id + "cardbg", in: namespace)
            )
            .padding(20)
            .matchedGeometryEffect(id: id + "cardoutside", in: namespace)
        }
    }
}

struct SimpleCard_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCard(id: "hi", title: "title", description: "desc.")
    }
}
