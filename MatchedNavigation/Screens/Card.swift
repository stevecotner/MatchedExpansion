//
//  Card.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct Card<Content>: View where Content: View {
    /// used for matchedGeometryEffect
    let id: String
    var hideContent: Bool = false
    let content: () -> Content
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            HStack {
                content()
                Spacer(minLength: 0)
            }
                .opacity(hideContent ? 0.001 : 1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 22)
                .padding(.bottom, 24)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.2), radius: 18, x: 0, y: 3)
                        .matchedGeometryEffect(id: id + "card" + "background", in: namespace)
                )
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(id: "hi", hideContent: false, content: { Text("hi") })
    }
}
