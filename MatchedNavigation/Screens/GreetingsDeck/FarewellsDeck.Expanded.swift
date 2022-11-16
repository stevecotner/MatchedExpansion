//
//  Farewells.Expanded.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

extension FarewellsDeck {
    struct Expanded: View {
        let items: [Farewell]
        
        @State var itemToExpand: Farewell?
        
        var body: some View {
            ZStack {
                ExpandedCardDeck(
                    id: "Farewells",
                    transitionWrapperIDPrefix: "FarewellsExpandedItem",
                    title: "Farewells",
                    items: items,
                    cardTapAction: { item in
                        itemToExpand = item
                    },
                    cardContent: { farewell in
                        /*
                         Every card can expand to show another screen
                         Because of this, the cardContent is a little busy.
                         Besides showing `FarewellCardContent(...)`, we also include:
                         1. A smart binding which can evaluate itemToExpand and compare it to the item's farewell.id
                         2. An ExpansionLink that goes to the new screen.
                         */
                        
                        VStack(spacing: 0) {
                            FarewellCardContent(farewell: farewell)
                            
                            let binding = Binding<Bool>(
                                get: { self.itemToExpand != nil && self.itemToExpand?.id == farewell.id },
                                set: {
                                    if $0 == false {
                                        // We need to specify that this is animated,
                                        // otherwise the collapse animation won't work correctly.
                                        withAnimation(Animation.collapseAnimation) {
                                            self.itemToExpand = nil
                                        }
                                    }
                                }
                            )
                            
                            // Each card has its own ExpansionLink
                            // (as opposed to making a single link further up in the FarewellsDeck.Expanded view).
                            // This is because we need to specify the transitionWrapperID *before* we tap the item,
                            // otherwise the expand and collapse animations won't work correctly.
                            // Trying to set that link and then trigger the animation creates insurmountable timing issues.
                            // It's because we make so many ExpansionLinks (one for each farewell item)
                            // that we need to get clever about the binding up above.
                            ExpansionLink(
                                viewMakerID: "FarewellsExpandedItem\(farewell.id)",
                                transitionWrapperID: "FarewellsExpandedItem\(farewell.id)",
                                isActive: binding,
                                transition: .split,
                                destination: {
                                    FarewellDetails(farewell: farewell)
                                })
                        }
                    }
                )
            }
        }
    }
    
    struct Expanded_Previews: PreviewProvider {
        static var previews: some View {
            Expanded(items: [Farewell(title: "Goodbye", description: "...")])
        }
    }
}
