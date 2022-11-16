//
//  DummyCard.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct DummyCard: View {
    /// used for matchedGeometryEffect
    let id: String
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            Rectangle()
                .fill(Color.clear)
                .frame(height: 20) // Dummy cards aren't very tall!
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

struct DummyCard_Previews: PreviewProvider {
    static var previews: some View {
        DummyCard(id: "hi")
    }
}
