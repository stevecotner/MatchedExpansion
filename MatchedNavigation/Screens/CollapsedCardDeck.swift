//
//  CollapsedCardDeck.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

struct CollapsedCardDeck<Item: CardItem, CardContent>: View where CardContent: View {
    /// Used for matchedGeometryEffect
    let id: String
    
    let title: String
    let items: [Item]
    let tapAction: () -> Void
    let cardContent: (Item) -> CardContent
    
    var body: some View {
        ExpansionNamespaceReader { namespace in
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.title2).bold()
                    Spacer(minLength: 0)
                }
                    .matchedGeometryEffect(id: id + "CardDeckTitle\(title)", in: namespace)
                
//                HStack {
//                    Text(title)
//                        .font(.headline)
//                    Spacer(minLength: 0)
//                }
//                .matchedGeometryEffect(id: id + "CardDeckTitle\(title)", in: namespace)
//                .padding(.horizontal, 20)
                
                Button {
                    tapAction()
                } label: {
                    ZStack {
                        // Buried Cards
                        if items.count > 3 {
                            ForEach(3..<items.count, id: \.self) { index in
                                let item = items[index]
    
                                DummyCard(id: id + item.id)
                                    .matchedGeometryEffect(id: id + "card" + item.id, in: namespace)
                                    .padding(.horizontal, 20 + CGFloat((min(5, index - 1)) * 10))
                                    .offset(y: 20)
                                    .opacity(0.001)
                                    .zIndex(Double(items.count - index))
                            }
                        }
                        
                        // 3rd card
                        if items.count > 2, let third = items[2] {
                            Card(id: id + third.id, hideContent: true, content: { cardContent(third) })
                                .matchedGeometryEffect(id: id + "card" + third.id, in: namespace)
                                .padding(.horizontal, 20)
                                .offset(y: 20)
                        }
                        
                        // 2nd card
                        if items.count > 1, let second = items[1] {
                            Card(id: id + second.id, hideContent: true, content: { cardContent(second) })
                                .matchedGeometryEffect(id: id + "card" + second.id, in: namespace)
                                .padding(.horizontal, 10)
                                .offset(y: 10)
                        }
                        
                        // Top card
                        if let first = items.first {
                            Card(id: id + first.id, content: { cardContent(first) })
                                .matchedGeometryEffect(id: id + "card" + first.id, in: namespace)
                                .padding(.horizontal, 0)
                        }
                    }
                    .padding(.bottom, items.count > 2 ? 30 : items.count > 1 ? 20 : 10)
                }
                .buttonStyle(BouncyButtonStyle())
                .accentColor(.black)
            }
        }
    }
}

struct CollapsedCardDeck_Previews: PreviewProvider {
    struct Item: CardItem {
        var id = UUID().uuidString
        var title: String
        var description: String
    }
    
    static let items: [Item] = [Item(title: "Hi", description: "desc")]
    
    static var previews: some View {
        CollapsedCardDeck(
            id: "Deck",
            title: "Deck",
            items: items,
            tapAction: {},
            cardContent: { item in
                Text(item.title)
            }
        )
    }
}
