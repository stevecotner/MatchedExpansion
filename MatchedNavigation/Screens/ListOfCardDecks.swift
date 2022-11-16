//
//  HelloView.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct ListOfCardDecks: View {
    @State var isGreetingsDeckExpanded = false
    @State var isFarewellsDeckExpanded = false
    
    @State var greetings: [Greeting] = [
        Greeting(title: "Hello", description: "A formal greeting."),
        Greeting(title: "Hi", description: "A somewhat casual greeting."),
        Greeting(title: "Hey", description: "A very casual greeting."),
        Greeting(title: "Yo", description: "A too casual greeting."),
        Greeting(title: "Aloha", description: "A Hawaiian greeting.")
    ]
    
    @State var farewells: [Farewell] = [
        Farewell(title: "Goodbye", description: "A formal farewell."),
        Farewell(title: "Bye", description: "A somewhat casual farewell."),
        Farewell(title: "See ya", description: "A very casual farewell."),
        Farewell(title: "Peace", description: "A too casual farewell."),
        Farewell(title: "Adios", description: "A Spanish farewell."),
        Farewell(title: "Ciao", description: "An Italian farewell."),
        Farewell(title: "Aloha", description: "A Hawaiian farewell."),
        Farewell(title: "Hasta la vista, baby", description: "A Terminator farewell."),
        Farewell(title: "Yippee Ki-Yay", description: "A Die Hard farewell."),
        Farewell(title: "Allons-y", description: "A Dr. Who farewell.")
    ]
    
    var body: some View {
        ZStack {
            ExpansionNamespaceReader { namespace in
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Card Decks")
                            .font(.title).bold()
                        
                        BodyText("This is a list of card decks and other elements. When the user taps on a card deck, the deck will unfold to take over the screen. All other elements will disappear above and below the unfolding card deck.")
                        
                        TransitionWrapper(id: "greetingsdeck") {
                            GreetingsDeck.Collapsed(
                                items: greetings,
                                tapAction: { isGreetingsDeckExpanded = true }
                            )
                        }
                        .padding(.bottom, 16)
                        
                        BodyText("The expanded card deck is a completely different view from the collapsed card deck. The animated transition from one view to the other relies on the matchedGeometryEffect. This separation of concerns lets the programmer make choices for each view without having to think about the state of a parent or child.")
                        
                        TransitionWrapper(id: "farewellsdeck") {
                            FarewellsDeck.Collapsed(
                                items: farewells,
                                tapAction: { isFarewellsDeckExpanded = true }
                            )
                        }
                        .padding(.bottom, 16)
                        
                        BodyText("The programmer is also able to expand to as many levels as they like: each view can expand to yet another view. So it's a composable pattern. But the code still needs to be cleaned up a little bit.")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.init(white: 0.96))
            }
            
            Group {
                ExpansionLink(
                    viewMakerID: "greetingsdeck",
                    transitionWrapperID: "greetingsdeck",
                    isActive: $isGreetingsDeckExpanded,
                    transition: .fade,
                    destination: {
                        GreetingsDeck.Expanded(items: greetings)
                    }
                )
                
                ExpansionLink(
                    viewMakerID: "farewellsdeck",
                    transitionWrapperID: "farewellsdeck",
                    isActive: $isFarewellsDeckExpanded,
                    transition: .split,
                    destination: {
                        FarewellsDeck.Expanded(items: farewells)
                    }
                )
            }
        }
    }
    
    func BodyText(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(.black.opacity(0.7))
            .padding(.bottom, 16)
    }
}

struct ListOfCardDecks_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ListOfCardDecks()
    }
}
