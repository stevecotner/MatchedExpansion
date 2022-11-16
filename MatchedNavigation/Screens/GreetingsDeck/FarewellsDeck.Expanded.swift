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
                            
                            // Each card has its own ExpansionLink.
                            // This is because we need to specify the transitionWrapperID *before* we tap the item,
                            // otherwise the expand and collapse animations won't work correctly.
                            ExpansionNamespaceReader { namespace in
                                ExpansionLink(
                                    viewMakerID: "FarewellsExpandedItem\(farewell.id)",
                                    transitionWrapperID: "FarewellsExpandedItem\(farewell.id)",
                                    isActive: binding,
                                    transition: .split,
                                    content: {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(farewell.title).bold()
                                                    .matchedGeometryEffect(id: "farewells" + "cardtitle" + farewell.id, in: namespace)
                                                
                                                Text(farewell.description)
                                                    .matchedGeometryEffect(id: "farewells" + "carddescription" + farewell.id, in: namespace)
                                                
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                        .padding(20)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white)
                                                .shadow(color: .black.opacity(0.01), radius: 18, x: 0, y: 3)
                                                .edgesIgnoringSafeArea([.top, .bottom])
                                                .matchedGeometryEffect(id: "Farewells" + farewell.id + "card" + "background", in: namespace)
                                        )
                                    })
                            }
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
