//
//  FarewellsDeck.Collapsed.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

extension FarewellsDeck {
    struct Collapsed: View {
        let items: [Farewell]
        let tapAction: () -> Void
        
        var body: some View {
            CollapsedCardDeck(
                id: "Farewells",
                title: "Farewells",
                items: items,
                tapAction: tapAction,
                cardContent: { farewell in
                    FarewellCardContent(farewell: farewell)
                }
            )
        }
    }
    
    struct Collapsed_Previews: PreviewProvider {
        static let farewells: [Farewell] = [Farewell(title: "Goodbye", description: "...", details: "...")]
        
        static var previews: some View {
            Collapsed(items: farewells, tapAction: {})
        }
    }
}
