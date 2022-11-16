//
//  CollapsedCardDeckOne.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

extension GreetingsDeck {
    struct Collapsed: View {
        let items: [Greeting]
        let tapAction: () -> Void
        
        var body: some View {
            CollapsedCardDeck(
                id: "Greetings",
                title: "Greetings",
                items: items,
                tapAction: tapAction,
                cardContent: { greeting in
                    GreetingCardContent(greeting: greeting)
                }
            )
        }
    }
    
    struct Collapsed_Previews: PreviewProvider {
        static let greetings: [Greeting] = [Greeting(title: "Hey", description: "...")]
        
        static var previews: some View {
            Collapsed(items: greetings, tapAction: {})
        }
    }
}
