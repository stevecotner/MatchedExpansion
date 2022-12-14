//
//  ExpandedCardDeckOne.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

extension GreetingsDeck {
    struct Expanded: View {
        let items: [Greeting]
        
        var body: some View {
            ExpandedCardDeck(
                id: "Greetings",
                title: "Greetings",
                items: items,
                cardTapAction: { _ in }, // TODO
                cardTransitionWrapperIDPrefix: "", // TODO (if we want to transition another level deep)
                cardContent: { greeting in
                    GreetingCardContent(greeting: greeting)
                }
            )
        }
    }
    
    struct Expanded_Previews: PreviewProvider {
        static var previews: some View {
            Expanded(items: [Greeting(title: "Hey", description: "...")])
        }
    }
}
