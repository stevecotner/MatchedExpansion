//
//  ExpandedCardDeck.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct ExpandedCardDeck<Item: CardItem, CardContent>: View where CardContent: View {
    /// Used for matchedGeometryEffect
    let id: String
    
    let title: String
    let items: [Item]
    let cardTapAction: (Item) -> Void
    let cardTransitionWrapperIDPrefix: String
    let cardContent: (Item) -> CardContent
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                        .frame(height: 10)
                    
                    HStack {
                        Text(title)
                            .id(id + "CardDeckTitle\(title)")
                            .matchedGeometryEffect(id: id + "CardDeckTitle\(title)", in: namespace)
                            .font(.title2).bold()
                        Spacer(minLength: 0)
                    }
                        .padding(.horizontal, 20)
                    
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        // Each card is in a transition wrapper.
                        // That's just in case we want to expand to yet another view.
                        // TransitionWrappers remove their content from the hierarchy when the content's mate is expanded.
                        TransitionWrapper(id: cardTransitionWrapperIDPrefix + item.id) {
                            Button {
                                cardTapAction(item)
                            } label: {
                                Card(
                                    id: id + item.id,
                                    content: {
                                        VStack(alignment: .leading) {
                                            cardContent(item)
                                        }
                                    })
                                    .matchedGeometryEffect(id: id + "card" + item.id, in: namespace)
                                    .padding(.horizontal, 20)
                                
                            }
                            .buttonStyle(BouncyButtonStyle())
                            .accentColor(.black)
                        }
                        .zIndex(Double(items.count - index))
                    }
                }
            }
            .background(Color.init(white: 0.96))
        }
    }
}

struct ExpandedCardDeck_Previews: PreviewProvider {
    struct Item: CardItem {
        var id = UUID().uuidString
        var title: String
        var description: String
    }
    
    static let items: [Item] = [Item(title: "Hi", description: "desc")]
    static var previews: some View {
        ExpandedCardDeck(
            id: "Deck",
            title: "Deck",
            items: items,
            cardTapAction: { _ in },
            cardTransitionWrapperIDPrefix: "",
            cardContent: { item in
                Text(item.title)
            }
        )
    }
}
