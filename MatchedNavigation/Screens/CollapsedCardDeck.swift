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
                        .id(id + "CardDeckTitle\(title)")
                        .matchedGeometryEffect(id: id + "CardDeckTitle\(title)", in: namespace)
                        .font(.title2).bold()
                    Spacer(minLength: 0)
                }
                
                Button {
                    tapAction()
                } label: {
                    cards()
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(title) Card Deck")
                }
                .buttonStyle(BouncyButtonStyle())
                .accentColor(.black)
            }
        }
    }
    
    func cards() -> some View {
        ExpansionNamespaceReader { namespace in
            ZStack(alignment: .bottom) {
                // Buried Cards
                if items.count > 1 {
                    ForEach(1..<items.count, id: \.self) { index in
                        let item = items[index]
                        
                        DummyCard(id: id + item.id)
                            .matchedGeometryEffect(id: id + "card" + item.id, in: namespace)
                            .padding(.horizontal, padding(for: index))
                            .offset(y: offset(for: index))
                            .opacity(opacity(for: index))
                            .zIndex(Double(items.count - index))
                    }
                }
                
//                // 3rd card
//                if items.count > 2, let third = items[2] {
//                    DummyCard(id: id + third.id)
//                        .matchedGeometryEffect(id: id + "card" + third.id, in: namespace)
//                        .padding(.horizontal, 20)
//                        .offset(y: 20)
//                        .zIndex(Double(items.count - 2))
//                }
//
//                // 2nd card
//                if items.count > 1, let second = items[1] {
//                    DummyCard(id: id + second.id)
//                        .matchedGeometryEffect(id: id + "card" + second.id, in: namespace)
//                        .padding(.horizontal, 10)
//                        .offset(y: 10)
//                        .zIndex(Double(items.count - 1))
//                }
                
                // Top card
                if let first = items.first {
                    Card(
                        id: id + first.id,
                        content: {
                            cardContent(first)
                        }
                    )
                        .matchedGeometryEffect(id: id + "card" + first.id, in: namespace)
                        .padding(.horizontal, 0)
                        .zIndex(Double(items.count))
                }
            }
            .padding(.bottom, items.count > 2 ? 30 : items.count > 1 ? 20 : 10)
        }
    }
    
    func padding(for index: Int) -> CGFloat {
        CGFloat((min(6, index)) * 10)
    }
    
    func offset(for index: Int) -> CGFloat {
        index == 1 ? 10 : 20
    }
    
    func opacity(for index: Int) -> CGFloat {
        index < 3 ? 1 : 0.001
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
